//
//  SquareViewCell.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 26.07.2022.
//

import UIKit

class SquareViewCell: UICollectionViewCell {
    
    static let id = "SquareViewCellID"
    
    private enum Constants {
        static let topInset: CGFloat = 24
        static let trailingInset: CGFloat = 16
        
        static let fontBold: String = "LabGrotesque-Bold"
        static let fontLight: String = "LabGrotesque-Light"
        
        static let valueTextSize: CGFloat = 18
        static let nameTextSize: CGFloat = 18
        
        static let firstLaunch: String = "Первый запуск"
        static let country: String = "Страна"
        static let cost: String = "Стоимость запуска"
        
        static let countEngines: String = "Количество двигателей"
        static let fuel: String = "Количество топлива"
        static let burnTime: String = "Время сгорания"
        
    }
    
    let nameLabels = [
        getLabel(text: nil,
                 font: Constants.fontLight,
                 size: Constants.nameTextSize),
        getLabel(text: nil,
                 font: Constants.fontLight,
                 size: Constants.nameTextSize),
        getLabel(text: nil,
                 font: Constants.fontLight,
                 size: Constants.nameTextSize)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        makeNameLabelsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeNameLabelsConstraints() {
        
        for nameLabel in nameLabels {
            addSubview(nameLabel)
        }
        NSLayoutConstraint.activate([
            nameLabels[0].leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabels[0].topAnchor.constraint(equalTo: topAnchor),
            
            nameLabels[1].leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabels[1].topAnchor.constraint(equalTo: nameLabels[0].bottomAnchor,
                                               constant: Constants.topInset),
            nameLabels[2].leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabels[2].topAnchor.constraint(equalTo: nameLabels[1].bottomAnchor,
                                               constant: Constants.topInset)
        ])
    }
    
}

// MARK: - Create UI elements

extension SquareViewCell {
    
    static private func getLabel(text: String?, font: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: font, size: size)
        label.text = text
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}


// MARK: - Configure cell
extension SquareViewCell {
    
    func configure(values: [String], indexPath: IndexPath) {
        guard values.count == 3 else { return }
        if indexPath.section == 2 {
            buildGeneralInfoCell(values: values)
        } else {
            buildStageInfoCell(values: values)
        }
    }
    
    private func buildGeneralInfoCell(values: [String]) {
        nameLabels[0].text = Constants.firstLaunch
        nameLabels[1].text = Constants.country
        nameLabels[2].text = Constants.cost
        
        let valueLabels = values.map({ value in
            SquareViewCell.getLabel(text: value,
                                    font: Constants.fontLight,
                                    size: Constants.nameTextSize)
        })
        for valueLabel in valueLabels {
            addSubview(valueLabel)
        }
        
        // constraints
        NSLayoutConstraint.activate([
            valueLabels[0].centerYAnchor.constraint(equalTo: nameLabels[0].centerYAnchor),
            valueLabels[0].trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueLabels[1].centerYAnchor.constraint(equalTo: nameLabels[1].centerYAnchor),
            valueLabels[1].trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueLabels[2].centerYAnchor.constraint(equalTo: nameLabels[2].centerYAnchor),
            valueLabels[2].trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func buildStageInfoCell(values: [String]) {
        nameLabels[0].text = Constants.countEngines
        nameLabels[1].text = Constants.fuel
        nameLabels[2].text = Constants.burnTime
        
        let valueLabels = values.map({ value in
            SquareViewCell.getLabel(text: value,
                                    font: Constants.fontBold,
                                    size: Constants.valueTextSize)
        })
        for valueLabel in valueLabels {
            addSubview(valueLabel)
        }
        
        // constraints
        NSLayoutConstraint.activate([
            valueLabels[0].centerYAnchor.constraint(equalTo: nameLabels[0].centerYAnchor),
            valueLabels[0].trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.trailingInset),
            valueLabels[1].centerYAnchor.constraint(equalTo: nameLabels[1].centerYAnchor),
            valueLabels[1].trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.trailingInset),
            valueLabels[2].centerYAnchor.constraint(equalTo: nameLabels[2].centerYAnchor),
            valueLabels[2].trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.trailingInset)
        ])
    }
}
