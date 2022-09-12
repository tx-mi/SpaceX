//
//  RocketCollectionView.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 25.07.2022.
//

import UIKit

class RocketCollectionView: UICollectionView {
    
    var viewModel: ViewModelProtocol
    
    let rocketID: Int
    
    var rocket: Rocket?
    
    init(frame: CGRect, id: Int, viewModel: ViewModelProtocol) {
        self.rocketID = id
        self.viewModel = viewModel
        super.init(frame: frame, collectionViewLayout: RocketCollectionView.configureLayout())
        
        setupViewModel(id: id)
        registerCells()
        delegate = self
        dataSource = self
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewModel(id: Int) {
        
        self.viewModel.didUpdateRockets = { [ weak self ] rockets in
            self?.rocket = rockets[id]
            self?.reloadData()
        }
        viewModel.getRockets()
    }
    
    func registerCells() {
        register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.id)
        register(MainInfoViewCell.self, forCellWithReuseIdentifier: MainInfoViewCell.id)
        register(SquareViewCell.self, forCellWithReuseIdentifier: SquareViewCell.id)
        
        // suplementaryViews
        register(HeaderView.self,
                 forSupplementaryViewOfKind:HeaderView.kind,
                 withReuseIdentifier: HeaderView.id)
        register(LabelHeadlineView.self,
                 forSupplementaryViewOfKind: LabelHeadlineView.kind,
                 withReuseIdentifier: LabelHeadlineView.id)
        register(ButtonFooterView.self,
                 forSupplementaryViewOfKind: ButtonFooterView.kind,
                 withReuseIdentifier: ButtonFooterView.id)
    }
    
}

// MARK: - UICollectionViewDelegate

extension RocketCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 4
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return setupImageCell(indexPath: indexPath)
        case 1:
            return setupMainInfoCell(indexPath: indexPath)
        default:
            return setupSquareCell(indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case "Header":
            return setupHeaderView(kind: kind, indexPath: indexPath)
        case "Label":
            return setupLabelHeadlineView(kind: kind, indexPath: indexPath)
        default:
            return setupButtonFooterView(kind: kind, indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
}

// MARK: - Setup cells and suplemetaryVies

private extension RocketCollectionView {
    
    func setupImageCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: ImageViewCell.id,
                                             for: indexPath) as? ImageViewCell
        else { return UICollectionViewCell() }
        
        guard
            let rocket = rocket,
            let stringUrl = rocket.flickr_images.randomElement(),
            let url = URL(string: stringUrl)
        else { return cell }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        cell.configure(image: image)
                    }
                }
            }
        }
        
        return cell
    }
    
    func setupMainInfoCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: MainInfoViewCell.id,
                                             for: indexPath) as? MainInfoViewCell
        else { return UICollectionViewCell() }
        guard let rocket = rocket else { return  cell }
        var data: (String, String)
        switch indexPath.row {
        case 0:
            data = rocket.getHeight
        case 1:
            data = rocket.getDiameter
        case 2:
            data = rocket.getMass
        default:
            data = rocket.getPayloadWeights
        }
        cell.configure(name: data.1, value: data.0)
        return cell
    }
    
    func setupSquareCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: SquareViewCell.id,
                                             for: indexPath) as? SquareViewCell
        else { return UICollectionViewCell() }
        guard let rocket = rocket else { return  cell }
        var stage: Stage
        
        switch indexPath.section {
        case 3:
            stage = rocket.first_stage
        case 4:
            stage = rocket.second_stage
        default:
            cell.configure(
                values: [rocket.getFirstFlight,
                         rocket.country,
                         String(rocket.cost_per_launch)],
                indexPath: indexPath)
            return cell
        }
        cell.configure(
            values: [String(stage.engines),
                     String(stage.fuel_amount_tons),
                     stage.burn_time_sec != nil ? String(stage.burn_time_sec!): ""],
            indexPath: indexPath)
        return cell
    }
    
    func setupHeaderView(kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath) as? HeaderView
        else { return HeaderView() }
        view.configure(rocketName: rocket?.name ?? "")
        view.moveTo = { [weak self] screen in
            self?.viewModel.route(to: screen, rocket: nil)
        }
        return view
    }
    
    func setupLabelHeadlineView(kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LabelHeadlineView.id, for: indexPath) as? LabelHeadlineView
        else { return LabelHeadlineView() }
        if indexPath.section == 2 {
            view.isHidden = true
        } else if indexPath.section == 3 {
            view.configure(titleLabelText: "Первая ступень")
        } else {
            view.configure(titleLabelText: "Вторая ступень")
        }
        return view
    }
    
    func setupButtonFooterView(kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ButtonFooterView.id, for: indexPath) as? ButtonFooterView
        else { return UICollectionReusableView() }
        if indexPath.section != 4 {
            view.isHidden = true
        } else {
            view.moveTo = { [weak self] screen in
                self?.viewModel.route(to: screen, rocket: self?.rocketID)
            }
        }
        return view
    }
    
}
