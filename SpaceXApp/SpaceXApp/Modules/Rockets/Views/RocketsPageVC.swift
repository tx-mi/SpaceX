//
//  RocketsPageVC.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 25.07.2022.
//

import UIKit

class RocketsPageVC: UIPageViewController {

    private var viewModel: ViewModelProtocol
    
    private var rockets: [Rocket]?
    
    private var rocketsVC: [RocketVC] = [RocketVC]()

    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        dataSource = self
        delegate = self
        
        viewModel.didUpdateRockets = { [weak self] rockets in
            guard let self = self else { return }
            self.rockets = rockets
            self.createViewControllers()
            self.setViewControllers([self.rocketsVC[0]], direction: .forward, animated: true)
            self.reloadInputViews()
        }
        viewModel.getRockets()
    }
    
    private func createViewControllers() {
        guard let rockets = rockets, rocketsVC.isEmpty else { return }

        for i in 0..<rockets.count {
            rocketsVC.append(RocketVC(rocketID: i, viewModel: viewModel))
        }
    }
    
}

extension RocketsPageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketVC else { return nil }
        let index = viewController.rocketID
        reloadInputViews()
        if index != 0 {
            return rocketsVC[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketVC, let rockets = rockets else { return nil }
        let index = viewController.rocketID
        reloadInputViews()
        if index != rockets.count - 1 {
            return rocketsVC[index + 1]
        }
        return nil

    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        rockets?.count ?? 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int { 0 }
}
