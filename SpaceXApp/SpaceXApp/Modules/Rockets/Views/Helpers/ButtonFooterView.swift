//
//  ButtonFooterView.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 26.07.2022.
//

import UIKit

class ButtonFooterView: UICollectionReusableView {
    
    static let id = "ButtonFooterViewID"
    static let kind = "Button"
    
    private enum Constants {
        static let trailngInset: CGFloat = 10 // Костыль изза специфики SuplementaryView
        static let buttonTextSize: CGFloat = 18
        static let buttonRadius: CGFloat = 15
        
        static let fontBold: String = "LabGrotesque-Bold"
    }
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blondGray
        button.layer.cornerRadius = Constants.buttonRadius
        button.clipsToBounds = true
        button.setTitle("Посмотреть запуски", for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.fontBold,
                                         size: Constants.buttonTextSize)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        
        addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.trailngInset),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2)
       ])
    }
}
