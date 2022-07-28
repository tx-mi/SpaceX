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
    func getRandomRocketImage(from rocket: Rocket) -> UIImage?
    func getRockets()
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
    
    func getRandomRocketImage(from rocket: Rocket) -> UIImage? {
        guard
            let stringUrl = rocket.flickr_images.randomElement(),
            let url = URL(string: stringUrl)
        else { return nil }
        
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    func getRockets() {
        guard rockets.count == 0 else { didUpdateRockets?(rockets); return }
        
        network?.fetchRockets(
            searchTerm: .getRockets,
            completion: { [weak self] rockets in
                guard let self = self else { return }
                self.rockets = rockets ?? []
            })
    }
    
}
