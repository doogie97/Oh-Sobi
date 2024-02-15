//
//  HomeSectionView.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/15/24.
//

import UIKit
import SnapKit

final class HomeSectionView: UIView {
    func setViewContents() {
        setLayout()
    }
    
    private func setLayout() {
        let view = UIView()
        view.backgroundColor = .systemBlue
        self.addSubview(view)
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
