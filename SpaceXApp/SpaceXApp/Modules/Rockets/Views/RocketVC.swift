//
//  RocketVC.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 25.07.2022.
//

import UIKit

class RocketVC: UIViewController {

    // Properties
    var rocketID: Int
    
    private var viewModel: ViewModelProtocol
    
    private var collectionView: UICollectionView!
    
    init(rocketID: Int, viewModel: ViewModelProtocol) {
        self.rocketID = rocketID
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = RocketCollectionView(frame: view.bounds,
                                              id: rocketID,
                                              viewModel: viewModel)
 
        makeConstraints()
    }
    
}

// MARK: - CollectionView

extension RocketVC {
    
    func makeConstraints() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
