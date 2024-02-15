//
//  UIFont + Extenstion.swift
//  Oh-Sobi
//
//  Created by Doogie on 2/14/24.
//

import UIKit

extension UIFont {
    enum Family: String {
        case Black, Regular, Bold, SemiBold
    }
    
    static func pretendard(_ family: Family, _ size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(family)", size: size) ?? UIFont.preferredFont(forTextStyle: .body)
    }
}

