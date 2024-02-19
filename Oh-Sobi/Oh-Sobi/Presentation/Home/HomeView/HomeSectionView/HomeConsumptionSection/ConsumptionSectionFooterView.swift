//
//  ConsumptionSectionFooterView.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/19/24.
//

import UIKit
import SnapKit

final class ConsumptionSectionFooterView: UICollectionReusableView {
    private lazy var moreButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.titleLabel?.font = .pretendard(.Bold, 16)
        button.setTitleColor(.mainBlack, for: .normal)
        button.layer.borderColor = UIColor.mainBlack.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(touchMoreButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchMoreButton() {
        print("추후 viewModel과 연결")
    }
    
    func setViewContents() {
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(margin(.height, 16))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, -4))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

