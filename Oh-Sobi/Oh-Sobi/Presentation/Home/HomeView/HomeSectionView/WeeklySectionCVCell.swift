//
//  WeeklySectionCVCell.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/18/24.
//

import UIKit
import SnapKit

final class WeeklySectionCVCell: UICollectionViewCell {
    func setCellContents() {
        if self.contentView.subviews.isEmpty {
            setLayout()
        }
    }
    
    private func setLayout() {
        self.contentView.backgroundColor = .ivory
        self.contentView.layer.cornerRadius = 12
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
