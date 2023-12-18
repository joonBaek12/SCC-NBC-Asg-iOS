//
//  UILabel+Extension.swift
//  TodoList
//
//  Created by Joon Baek on 2023/12/18.
//

import UIKit

extension UILabel {
    func applyTextProperties(textColor: UIColor, strikethrough: Bool) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
            .strikethroughStyle: strikethrough ? NSUnderlineStyle.single.rawValue : 0
        ]
        
        let attributedText = NSAttributedString(string: self.text ?? "", attributes: attributes)
        self.attributedText = attributedText
    }
}
