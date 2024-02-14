//
//  HomeView.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/12/24.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    private lazy var dateLabel = pretendardLabel(family: .Black, size: 40, color: .mainred, text: "asdfasdf", textAlignment: .center)
    func setViewContents() {
        self.backgroundColor = .systemBlue
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
