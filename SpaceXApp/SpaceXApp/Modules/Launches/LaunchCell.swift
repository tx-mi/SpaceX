//
//  LaunchCell.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 12.09.2022.
//

import UIKit

class LaunchCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseId = "LaunchCellId"
    
    private enum Constants {
        static let cellHorizontalInset: CGFloat = 34
        static let imageSize: CGFloat = 50
        
        static let fontBold: String = "LabGrotesque-Bold"
        static let fontLight: String = "LabGrotesque-Light"
        
        static let nameLabelTextSize: CGFloat = 20
        static let dateLabelTextSize: CGFloat = 16
        
        static let horizontalInset: CGFloat = 24
        static let verticalInset: CGFloat = 24
    }
    
    // MARK: - Views
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "success")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blondGray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.fontBold,
                            size: Constants.nameLabelTextSize)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.font = UIFont(name: Constants.fontLight,
                            size: Constants.dateLabelTextSize)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCylce
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 25
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let width = UIScreen.main.bounds.size.width - 2 * Constants.cellHorizontalInset
        layoutAttributes.bounds.size.width = width
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    func configure(with model: Launch) {
        backgroundColor = .blondGray
        
        if let isSuccess = model.success,
           isSuccess == false {
            imageView.image = UIImage(named: "failure")
        }
        nameLabel.text = model.name
        dateLabel.text = model.getDateUTC
    }
    
}


// MARK: - Setup UI

private extension LaunchCell {
    
    func setupUI() {
        backgroundColor = .blondGray
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalInset),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalInset),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalInset),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalInset),
            
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
 
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: imageView.leadingAnchor,
                                                constant: -Constants.horizontalInset),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: imageView.leadingAnchor,
                                                constant: -Constants.horizontalInset),
            
       ])
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    
}
