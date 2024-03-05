//
//  WeeklySectionCVCell.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/18/24.
//

import UIKit
import SnapKit

final class WeeklySectionCVCell: UICollectionViewCell {
    private weak var viewModel: HomeVMable?
    private lazy var titleLabel = pretendardLabel(family: .Bold, size: 16, text: "주간 소비")
    private lazy var rightIndicator = {
        let indicator = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: indicator)
        imageView.tintColor = .mainBlack
        
        return imageView
    }()
    
    private lazy var moveCalendarButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(touchMoveCalendarButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func touchMoveCalendarButton() {
        viewModel?.touchMoveCalendarButton()
    }
    
    private lazy var weeklyStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private func setWeeklyStackView() {
        guard let weeklyConsumption = viewModel?.viewContents?.weeklyConsumption.weeklyConsumptionList else {
            return
        }
        
        for index in 0..<7 {
            let view = UIView()
            if let consumption = weeklyConsumption[safe: index] {
                let dayOfTheWeek = OhsobiDateManager.DayOfTheWeek(rawValue: index + 1)?.shortKorean
                let day = consumption?.day
                
                let dayOfTheWeekLabel = pretendardLabel(size: 12, text: dayOfTheWeek, textAlignment: .center)
                let dayLabel = pretendardLabel(family: .SemiBold, size: 14, text: day?.description, textAlignment: .center)
                let amountLabel = amountLabel(consumption: consumption)
                
                let button = UIButton()
                button.tag = index
                button.addTarget(self, action: #selector(touchWeeklyConsumption), for: .touchUpInside)
                view.addSubview(dayOfTheWeekLabel)
                view.addSubview(dayLabel)
                view.addSubview(amountLabel)
                view.addSubview(button)
                
                dayOfTheWeekLabel.snp.makeConstraints {
                    $0.top.leading.trailing.equalToSuperview()
                }
                
                dayLabel.snp.makeConstraints {
                    $0.top.equalTo(dayOfTheWeekLabel.snp.bottom).inset(margin(.height, -8))
                    $0.leading.trailing.equalToSuperview()
                }
                
                amountLabel.snp.makeConstraints {
                    $0.top.equalTo(dayLabel.snp.bottom).inset(margin(.height, -8))
                    $0.leading.trailing.equalToSuperview()
                }
                
                button.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
            weeklyStackView.addArrangedSubview(view)
        }
    }
    
    private func amountLabel(consumption: DailyConsumption?) -> UILabel {
        let amount = consumption?.consumptionList.reduce(0) { result, consumption in
            return result + consumption.amount
        }
        
        let amountLabel = pretendardLabel(size: 10, textAlignment: .center)
        if let amount = amount {
            if amount == 0 {
                amountLabel.text = "0"
            } else if amount > 0 {
                amountLabel.text = "+\(amount)"
                amountLabel.textColor = .mainGreen
            } else if amount < 0 {
                amountLabel.text = "\(amount)"
                amountLabel.textColor = .mainRed
            }
        }
        
        return amountLabel
    }
    
    @objc private func touchWeeklyConsumption(_ sender: UIButton) {
        viewModel?.touchWeeklyConsumption(sender.tag)
    }
    
    func setCellContents(viewModel: HomeVMable?) {
        self.viewModel = viewModel
        setWeeklyStackView()
        if self.contentView.subviews.isEmpty {
            setLayout()
        }
    }
    
    private func setLayout() {
        self.contentView.backgroundColor = .ivory
        self.contentView.layer.cornerRadius = 12
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(rightIndicator)
        self.contentView.addSubview(weeklyStackView)
        self.contentView.addSubview(moveCalendarButton)
        
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(margin(.width, 16))
        }
        
        rightIndicator.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(margin(.width, 24))
            $0.height.equalTo(16)
            $0.width.equalTo(8)
        }
        
        weeklyStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(margin(.height, -16))
            $0.leading.trailing.equalToSuperview().inset(margin(.width, 10))
            $0.bottom.equalToSuperview().inset(margin(.height, 16))
        }
        
        moveCalendarButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(weeklyStackView.snp.top)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        self.weeklyStackView.subviews.forEach { $0.removeFromSuperview() }
    }
}
