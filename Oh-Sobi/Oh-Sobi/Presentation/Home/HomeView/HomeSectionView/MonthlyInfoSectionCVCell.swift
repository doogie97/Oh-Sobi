//
//  MonthlyInfoSectionCVCell.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/18/24.
//

import UIKit
import SnapKit

final class MonthlyInfoSectionCVCell: UICollectionViewCell {
    func setCellContents() {
        if self.contentView.subviews.isEmpty {
            setLayout()
        }
    }
    
    private func setLayout() {
        self.contentView.layer.cornerRadius = 12
        self.contentView.backgroundColor = .ivoryBG
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
