//
//  HomeSectionView.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/15/24.
//

import UIKit
import SnapKit

final class HomeSectionView: UIView {
    private weak var viewModel: HomeVMable?
    private lazy var sectionCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: UICollectionViewLayout())
    
    func setViewContents(viewModel: HomeVMable?) {
        self.viewModel = viewModel
        sectionCollectionView = createSectionCollectionView()
        setLayout()
    }
    
    private func dailyConsumptionList() -> [Consumption] {
        guard let weeklyConsumption = viewModel?.viewContents?.weeklyConsumption else {
            return []
        }
        
        var consumptionList = [Consumption]()
        weeklyConsumption.weeklyConsumptionList.forEach {
            if let consumption = $0 {
                let consumptionDate =  consumption.date.yearMonthDay()
                let todayDate = Date().yearMonthDay()
                if consumptionDate.year == todayDate.year && consumptionDate.month == todayDate.month && consumptionDate.day == todayDate.day {
                    consumptionList = consumption.consumptionList
                }
            }
        }
        
        return consumptionList
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
        case consumptionState
        case monthlyInfo
        case consumptionList
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
        case .consumptionState:
            return 1
        case .monthlyInfo:
            return 2
        case .consumptionList:
            let count = dailyConsumptionList().count
            return count > 10 ? 10 : count
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
            cell.setCellContents(viewModel: self.viewModel)
            return cell
        case .consumptionState:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ConsumptionStateCVCell.self)", for: indexPath) as? ConsumptionStateCVCell else {
                return UICollectionViewCell()
            }
            cell.setCellContents()
            return cell
        case .monthlyInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MonthlyInfoSectionCVCell.self)", for: indexPath) as? MonthlyInfoSectionCVCell else {
                return UICollectionViewCell()
            }
            cell.setCellContents()
            return cell
        case .consumptionList:
            let dailyConsumptionList = dailyConsumptionList()
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeConsumptionListCVCell.self)", for: indexPath) as? HomeConsumptionListCVCell,
                  let consumption = dailyConsumptionList[safe: indexPath.row] else {
                return UICollectionViewCell()
            }
            cell.setCellContents(consumption: consumption)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = SectionCase(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        
        switch section {
        case .consumptionList:
            let dailyConsumptionList = dailyConsumptionList()
            if kind == UICollectionView.elementKindSectionFooter && dailyConsumptionList.count > 10 {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(ConsumptionSectionFooterView.self)", for: indexPath) as? ConsumptionSectionFooterView else {
                    return UICollectionReusableView()
                }
                header.setViewContents()
                return header
            } else {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HomeSectionHeaderView.self)", for: indexPath) as? HomeSectionHeaderView else {
                    return UICollectionReusableView()
                }
                header.setViewContents(title: "오늘의 소비")
                return header
            }
        case .weeklyConsumption, .consumptionState, .monthlyInfo:
            return UICollectionReusableView()
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
        collectionView.register(ConsumptionStateCVCell.self, forCellWithReuseIdentifier: "\(ConsumptionStateCVCell.self)")
        collectionView.register(MonthlyInfoSectionCVCell.self, forCellWithReuseIdentifier: "\(MonthlyInfoSectionCVCell.self)")
        collectionView.register(HomeConsumptionListCVCell.self, forCellWithReuseIdentifier: "\(HomeConsumptionListCVCell.self)")
        
        collectionView.register(HomeSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "\(HomeSectionHeaderView.self)")
        if self.dailyConsumptionList().count > 10 {
            collectionView.register(ConsumptionSectionFooterView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                    withReuseIdentifier: "\(ConsumptionSectionFooterView.self)")
        }
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
            case .consumptionState:
                return self?.consumptionStateSectionLayout()
            case .monthlyInfo:
                return self?.monthlyInfoSectionLayout()
            case .consumptionList:
                return self?.consumptionListSectionLayout()
            }
        }
    }
    
    private func weeklySectionLayout() -> NSCollectionLayoutSection {
        let ratio = 132.0 / 361.0
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(ratio))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(ratio))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: margin(.height, 24),
                                      leading: margin(.width, 16),
                                      bottom: 0,
                                      trailing: margin(.width, 16))
        
        return section
    }
    
    private func consumptionStateSectionLayout() -> NSCollectionLayoutSection {
        let ratio = 140.0 / 361.0
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(ratio))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(ratio))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: margin(.height, 24),
                                      leading: margin(.width, 16),
                                      bottom: 0,
                                      trailing: margin(.width, 16))
        
        return section
    }
    
    private func monthlyInfoSectionLayout() -> NSCollectionLayoutSection {
        let ratio = 100.0 / 361
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .fractionalWidth(ratio))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 0,
                                   leading: margin(.width, 10),
                                   bottom: 0,
                                   trailing: margin(.width, 10))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(ratio))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0,
                                    leading: margin(.width, 6),
                                    bottom: 0,
                                    trailing: margin(.width, 6))
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = .init(top: margin(.height, 24),
                                      leading: 0,
                                      bottom: 0,
                                      trailing: 0)
        
        return section
    }
    
    private func consumptionListSectionLayout() -> NSCollectionLayoutSection {
        let heigt = 50 + margin(.height, 24)
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(heigt))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: margin(.height, 12), leading: 0, bottom: margin(.height, 12), trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(heigt))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(margin(.height, 36) + 20))
        section.boundarySupplementaryItems = [.init(layoutSize: sectionHeaderSize,
                                                    elementKind: UICollectionView.elementKindSectionHeader,
                                                    alignment: .topLeading)]
        if dailyConsumptionList().count > 10 {
            let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(margin(.height, 16 * 2) + 45))
            section.boundarySupplementaryItems.append(.init(layoutSize: sectionFooterSize,
                                                            elementKind: UICollectionView.elementKindSectionFooter,
                                                            alignment: .bottomLeading))
        }
        
        section.contentInsets = .init(top: 0,
                                      leading: margin(.width, 24),
                                      bottom: 0,
                                      trailing: margin(.width, 24))
        
        return section
    }
}
