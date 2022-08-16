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
    func showSettigns()
}

final class ViewModel: ViewModelProtocol {
    
    var didUpdateRockets: (([Rocket]) -> Void)?
    
    private(set) var rockets: [Rocket] = [Rocket]() {
        didSet {
            didUpdateRockets?(rockets)
        }
    }
    
    private var network: NetworkDataFetchProtocol?
    
    init() {
        network = NetworkDataFetch()
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
    
    func showSettigns() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        UINavigationController().present(vc, animated: true)
    }
    
}
