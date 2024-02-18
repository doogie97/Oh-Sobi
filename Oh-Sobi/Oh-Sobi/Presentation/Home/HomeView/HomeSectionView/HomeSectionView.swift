//
//  HomeSectionView.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/15/24.
//

import UIKit
import SnapKit

final class HomeSectionView: UIView {
    private lazy var sectionCollectionView = UICollectionView(frame: .zero,
                                                                   collectionViewLayout: UICollectionViewLayout())
    
    func setViewContents() {
        sectionCollectionView = createSectionCollectionView()
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(sectionCollectionView)
        
        sectionCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension HomeSectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    enum SectionCase: Int, CaseIterable {
        case weeklyConsumption = 0
//        case consumptionState
//        case consumptionList
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionCase.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = SectionCase(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .weeklyConsumption:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = SectionCase(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch section {
        case .weeklyConsumption:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(WeeklySectionCVCell.self)", for: indexPath) as? WeeklySectionCVCell else {
                return UICollectionViewCell()
            }
            cell.setCellContents()
            return cell
        }
    }
}

extension HomeSectionView {
    private func createSectionCollectionView() -> UICollectionView {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(WeeklySectionCVCell.self, forCellWithReuseIdentifier: "\(WeeklySectionCVCell.self)")
        
        return collectionView
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let section = SectionCase(rawValue: sectionIndex) else {
                return nil
            }
            
            switch section {
            case .weeklyConsumption:
                return self?.weeklySectionLayout()
            }
        }
    }
    
    private func weeklySectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.37))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.37))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: margin(.height, 16),
                                      leading: margin(.width, 16),
                                      bottom: margin(.height, 16),
                                      trailing: margin(.width, 16))
        
        return section
    }
}
