//
//  LaunchesVC.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 12.09.2022.
//

import UIKit

final class LaunchesVC: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let collectionViewInsets: UIEdgeInsets = .init(
            top: 34,
            left: horizontalInset,
            bottom: 0,
            right: horizontalInset
        )
        static let horizontalInset: CGFloat = 34
        static let minimumLineSpacing: CGFloat = 24
    }
    
    // MARK: - Properties
    
    private var viewModel: ViewModelProtocol
    
    private var collectionView: UICollectionView!
    
    private var launches: [Launch] = [Launch]()
    
    // MARK: - Init
    
    init(viewModel: ViewModelProtocol, titleName: String) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = titleName
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        makeConstraints()
        setupCollectionFlowLayout()
        setupViewModel()
        setupCollectionView()
        setupUI()
    }
    
    private func setupViewModel() {
        viewModel.didUpdateLaunches = { [weak self] launches in
            guard let self = self else { return }
            self.launches = launches
            self.collectionView.reloadData()
        }
        viewModel.getLaunches()
        
    }
}


// MARK: - Setup collectionView

private extension LaunchesVC {
    
    func setupCollectionFlowLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = Constants.collectionViewInsets
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        collectionView.collectionViewLayout = layout
    }
    
    func setupCollectionView() {
        self.collectionView.register(
            LaunchCell.self,
            forCellWithReuseIdentifier: LaunchCell.reuseId
        )
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setupUI() {
        self.collectionView.backgroundColor = .black
    }
    
    func makeConstraints() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


// MARK: - Delegate, DataSource

extension LaunchesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LaunchCell.reuseId,
            for: indexPath
        ) as? LaunchCell else { return UICollectionViewCell() }
        
        let launch = launches[indexPath.row]
        
        cell.configure(with: launch)
        return cell
    }
    
}

// MARK: - FlowLayout - немножко пошло нахуй

//extension LaunchesVC: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let size = CGSize(width: view.frame.width - 2 * Constants.horizontalInset,
//                          height: view.frame.height / 5 - 2 * Constants.horizontalInset)
//        return size
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        Constants.minimumLineSpacing
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        Constants.collectionViewInsets
//    }
//
//}
