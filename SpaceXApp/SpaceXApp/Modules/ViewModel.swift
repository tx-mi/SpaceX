//
//  RocketsViewModel.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 25.07.2022.
//

import Foundation
import UIKit

protocol ViewModelProtocol {
    var rockets: [Rocket] { get }
    var didUpdateRockets: (([Rocket]) -> Void)? { get set }
    func getRockets()
    func route(to screens: Screens)
}

final class ViewModel: ViewModelProtocol {
    
    var didUpdateRockets: (([Rocket]) -> Void)?
    
    let navigationContorller: UINavigationController
    
    private(set) var rockets: [Rocket] = [Rocket]() {
        didSet {
            didUpdateRockets?(rockets)
        }
    }
    
    private var network: NetworkDataFetchProtocol?
    
    init(navigationContorller: UINavigationController) {
        network = NetworkDataFetch()
        self.navigationContorller = navigationContorller
    }
}

extension ViewModel {
    
    func getRockets() {
        guard rockets.count == 0 else { didUpdateRockets?(rockets); return }
        
        network?.fetchRockets(
            searchTerm: .getRockets,
            completion: { [weak self] rockets in
                guard let self = self else { return }
                self.rockets = rockets ?? []
            })
    }
    
    func route(to screen: Screens) {
        let vc = UIViewController()
        
        switch screen {
        case .settings:
            vc.view.backgroundColor = .red
            navigationContorller.present(vc, animated: true)
        case .launches:
            vc.view.backgroundColor = .blue
            navigationContorller.pushViewController(vc, animated: true)
        }
    }
    
}
