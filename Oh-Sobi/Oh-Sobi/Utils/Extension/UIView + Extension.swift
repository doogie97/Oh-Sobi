//
//  UIView + Extension.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/14/24.
//

import UIKit
extension UIView {
    func pretendardLabel(family: UIFont.Family = .Regular, size: CGFloat = 14, color: UIColor = .black, lineCount: Int = 1, text: String? = "", textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = .pretendard(family, size)
        label.textColor = color
        label.numberOfLines = lineCount
        label.text = text
        label.textAlignment = textAlignment
        
        return label
    }
}
