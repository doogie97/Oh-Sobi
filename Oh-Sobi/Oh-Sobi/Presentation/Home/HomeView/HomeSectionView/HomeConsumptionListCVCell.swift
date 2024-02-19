//
//  HomeConsumptionListCVCell.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/19/24.
//

import UIKit
import SnapKit

final class HomeConsumptionListCVCell: UICollectionViewCell {
    func setCellContents() {
        if self.contentView.subviews.isEmpty {
            setLayout()
        }
    }
    
    private func setLayout() {
        self.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
