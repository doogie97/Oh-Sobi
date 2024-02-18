//
//  WeeklySectionView.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/15/24.
//

import UIKit
import SnapKit

final class WeeklySectionView: UIView {
    private lazy var sectionView = {
        let view = UIView()
        view.backgroundColor = UIColor.ivory
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    func setViewContents() {
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(sectionView)
        
        sectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(margin(.height, 16))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 16))
            $0.bottom.equalToSuperview()
            
            $0.height.equalTo(132)
        }
    }
}
