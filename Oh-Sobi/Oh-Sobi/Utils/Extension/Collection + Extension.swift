//
//  Collection + Extension.swift
//  Oh-Sobi
//
//  Created by Doogie on 3/5/24.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
