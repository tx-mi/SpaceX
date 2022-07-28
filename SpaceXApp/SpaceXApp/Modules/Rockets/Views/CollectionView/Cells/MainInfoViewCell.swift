//
//  MainInfoViewCell.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 26.07.2022.
//

import UIKit

class MainInfoViewCell: UICollectionViewCell {
    
    static let id = "MainInfoViewCellID"
    
    private enum Constants {
        static let topInset: CGFloat = 5
        static let bottomInset: CGFloat = 10
        
        static let fontBold: String = "LabGrotesque-Bold"
        static let fontLight: String = "LabGrotesque-Light"
        
        static let valueLabelTextSize: CGFloat = 18
        static let descriptionLabelTextSize: CGFloat = 16
    }
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontBold,
                            size: Constants.valueLabelTextSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.font = UIFont(name: Constants.fontLight,
                            size: Constants.descriptionLabelTextSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        descriptionLabel.text = nil
    }
    
    private func setupView() {
        backgroundColor = .blondGray
        layer.cornerRadius = frame.width / 3
    }
    
    private func makeConstraints() {
        addSubview(valueLabel)
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor,
                                                constant: -(Constants.bottomInset)),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor,
                                                  constant: Constants.topInset)
        ])
    }
}

extension MainInfoViewCell {
    
    func configure(name: String, value: String) {
        valueLabel.text = value
        descriptionLabel.text = name
    }
}
