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
    
    var launches: [Launch] { get }
    var didUpdateLaunches: (([Launch]) -> Void)? { get set }
    func getLaunches()
    
    func route(to screens: Screens, rocket id: Int?)
    
}

final class ViewModel: ViewModelProtocol {
    
    var didUpdateRockets: (([Rocket]) -> Void)?
    
    var didUpdateLaunches: (([Launch]) -> Void)?
    
    let navigationContorller: UINavigationController
    
    private(set) var rockets: [Rocket] = [Rocket]() {
        didSet {
            didUpdateRockets?(rockets)
        }
    }
    
    private(set) var launches: [Launch] = [Launch]() {
        didSet {
            didUpdateLaunches?(launches)
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
    
    func getLaunches() {
        guard launches.count == 0 else { didUpdateLaunches?(launches); return }
        
        network?.fetchLaunches(
            searchTerm: .getLaunches,
            completion: { [weak self] launches in
                guard let self = self else { return }
                self.launches = launches ?? []
            })
    }
    
    func route(to screen: Screens, rocket id: Int?) {
        var vc = UIViewController()
        
        switch screen {
        case .settings:
            vc.view.backgroundColor = .red
            navigationContorller.present(vc, animated: true)
        case .launches:
            vc = LaunchesVC(viewModel: self, titleName: rockets[id ?? 0].name)
            navigationContorller.pushViewController(vc, animated: true)
        }
    }
    
}
