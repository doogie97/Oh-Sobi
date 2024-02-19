//
//  HomeSectionHeaderView.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/19/24.
//

import UIKit
import SnapKit

final class HomeSectionHeaderView: UICollectionReusableView {
    private lazy var titleLabel = pretendardLabel(family: .Bold, size: 18)
    func setViewContents(title: String) {
        titleLabel.text = title
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(margin(.height, 24))
            $0.bottom.equalToSuperview().inset(margin(.height, 12))
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }
}
