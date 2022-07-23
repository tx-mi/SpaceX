//
//  ViewController.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 23.07.2022.
//

import UIKit

class ViewController: UIViewController {

    let network = NetworkDataFetch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        network.fetchRockets(searchTerm: .getRockets) { rockets in
            print(rockets ?? "suka")
        }
//        network.fetchLaunches(searchTerm: .getLaunches) { rockets in
//            print(rockets ?? "suka")
//        }
    }


}

