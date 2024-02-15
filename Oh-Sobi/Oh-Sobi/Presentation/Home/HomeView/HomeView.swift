//
//  HomeView.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/12/24.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    private lazy var dayLabel = pretendardLabel(family: .Bold, size: 18)
    private lazy var dateLabel = pretendardLabel(family: .Regular, size: 14)
    
    private lazy var homeSectionView = HomeSectionView()
    
    func setViewContents() {
        homeSectionView.setViewContents()
        setDateLabel()
        setLayout()
    }
    
    private func setDateLabel() {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.string(from: currentDate)
        
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        let dateString = dateFormatter.string(from: currentDate)
        
        dayLabel.text = dayString
        dateLabel.text = dateString
    }
    
    private func setLayout() {
        self.addSubview(dayLabel)
        self.addSubview(dateLabel)
        self.addSubview(homeSectionView)
        
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(margin(.height, 20))
            $0.leading.equalToSuperview().inset(margin(.width, 24))
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).inset(margin(.height, -4))
            $0.leading.equalTo(dayLabel)
        }
        
        homeSectionView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
