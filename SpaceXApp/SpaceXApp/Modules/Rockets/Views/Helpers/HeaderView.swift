//
//  HeaderView.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 26.07.2022.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    static let id = "categoryHeaderID"
    static let kind = "Header"
    
    var moveTo: ((Screens) -> Void)?
    
    private enum Constants {
        static let leadingInset: CGFloat = 32
        static let trailngInset: CGFloat = 32
        static let topInset: CGFloat = 32
        static let bottomInset: CGFloat = 32
        
        static let fontRegular: String = "LabGrotesque-Regular"
        static let labeTextSize: CGFloat = 34
    }
    
    let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontRegular, size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        roundCorners(corners: [.topLeft, .topRight], radius: 30)
        backgroundColor = .black
        makeConstraints()
        settingsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rocketNameLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc private func buttonPressed() {
        moveTo?(.settings)
    }
    
    private func makeConstraints() {
        addSubview(rocketNameLabel)
        addSubview(settingsButton)
        NSLayoutConstraint.activate([
            rocketNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingInset),
            rocketNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.bottomInset),
            
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.trailngInset),
            settingsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.bottomInset),
        ])
    }
}

extension HeaderView {
    func configure(rocketName: String) {
        rocketNameLabel.text = rocketName
    }
}

