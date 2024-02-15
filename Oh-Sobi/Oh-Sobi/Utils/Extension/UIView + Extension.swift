//
//  UIView + Extension.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/14/24.
//

import UIKit
extension UIView {
    enum Direction {
        case height
        case width
    }
    
    func margin(_ direction: Direction, _ margine: Double) -> Double {
        let designHeight: Double = 852
        let designWidth: Double = 393
        
        switch direction {
        case .height:
            return UIScreen.main.bounds.height * margine/designHeight
        case .width:
            return UIScreen.main.bounds.width * margine/designWidth
        }
    }
    
    var isSE: Bool {
        return UIScreen.main.bounds.height <= 667
    }
    
    var isMini: Bool {
        return UIScreen.main.bounds.width <= 375 && UIScreen.main.bounds.height > 667
    }
    
    func pretendardLabel(family: UIFont.Family = .Regular, size: CGFloat = 14, color: UIColor = .mainBlack, lineCount: Int = 1, text: String? = "", textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = .pretendard(family, size)
        label.textColor = color
        label.numberOfLines = lineCount
        label.text = text
        label.textAlignment = textAlignment
        
        return label
    }
}
