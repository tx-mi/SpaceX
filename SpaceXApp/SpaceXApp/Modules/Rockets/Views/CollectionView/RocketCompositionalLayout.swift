//
//  RocketCompositionalLayout.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 25.07.2022.
//

import UIKit

extension RocketCollectionView {
    
    static func configureLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            (sectionIndex, enviroment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return createImageLayout()
            case 1:
                return createMainInfoLayout()
            default:
                return createSquareLayout(sectionIndex: sectionIndex)
            }
        }
    }
    
    private static func createImageLayout() -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(0.55)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets.bottom = -30
        return section
    }
    
    private static func createMainInfoLayout() -> NSCollectionLayoutSection? {
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.28),
                              heightDimension: .fractionalWidth(0.28)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            .init(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .fractionalHeight(0.15)),
                elementKind: HeaderView.kind,
                alignment: .topLeading)
        ]
        section.interGroupSpacing = 12
        section.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private static func createSquareLayout(sectionIndex: Int) -> NSCollectionLayoutSection? {
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .estimated(120)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let height: NSCollectionLayoutDimension = .fractionalHeight(sectionIndex == 4 ? 0.15 : 0.05)
        section.boundarySupplementaryItems = [
            .init(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: .fractionalHeight(0.05)),
                elementKind: LabelHeadlineView.kind,
                alignment: .topLeading),
            .init(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                  heightDimension: height),
                elementKind: ButtonFooterView.kind,
                alignment: .bottomLeading)
        ]
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.supplementariesFollowContentInsets = true
        section.orthogonalScrollingBehavior = .none
        return section
    }
}
