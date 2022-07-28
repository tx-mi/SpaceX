//
//  LabelHeadlineView.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 26.07.2022.
//

import UIKit

class LabelHeadlineView: UICollectionReusableView {
    
    static let id = "LabelHeadlineViewID"
    static let kind = "Label"
    
    private enum Constants {
        static let trailngInset: CGFloat = 10 // Костыль изза специфики SuplementaryView
        
        static let fontBold: String = "LabGrotesque-Bold"
        static let titleLabelTextSize: CGFloat = 18
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontBold,
                            size: Constants.titleLabelTextSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    private func makeConstraints() {
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.trailngInset),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension LabelHeadlineView {
    
    func configure(titleLabelText: String) {
        self.titleLabel.text = titleLabelText.uppercased()
    }
}
