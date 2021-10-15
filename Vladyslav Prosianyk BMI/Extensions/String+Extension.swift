//
//  String+Extension.swift
//  Vladyslav Prosianyk BMI
//
//  Created by Vladyslav Prosianyk on 15.10.2021.
//

import UIKit

public enum AttributedStringOptions {
    case textColor(UIColor)
    case font(UIFont)
    case paragraphStyle(lineSpacing: CGFloat?, alignment: NSTextAlignment?)
    case indent(head: CGFloat, tail: CGFloat)
    case underLine(NSUnderlineStyle?,  UIColor?)
}

extension String {
    public func attributedString(font: UIFont = .systemFont(ofSize: 15), color: UIColor = UIColor.black, alignment: NSTextAlignment? = nil) -> NSMutableAttributedString {
        
        return self.attributed([.font(font), .textColor(color), .paragraphStyle(lineSpacing: nil, alignment: alignment)])
    }
    
    public func attributed(_ options: [AttributedStringOptions] = [.font(.systemFont(ofSize: 15)), .textColor(UIColor.black), .paragraphStyle(lineSpacing: nil, alignment: nil)]) -> NSMutableAttributedString {
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        
        var textColor: UIColor = UIColor.black
        
        var textFont: UIFont = .systemFont(ofSize: 15)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        options.forEach { (option) in
            switch option {
            case .textColor(let color):
                textColor = color
            case .font(let font):
                textFont = font
            case .paragraphStyle(let lineSpacing, let alignment):
                if let _alignment = alignment {
                    paragraphStyle.alignment = _alignment
                }
                if let _lineSpacing = lineSpacing {
                    paragraphStyle.lineSpacing = _lineSpacing
                }
            case .indent(let head, let tail):
                paragraphStyle.firstLineHeadIndent = head
                paragraphStyle.headIndent = head
                paragraphStyle.tailIndent = tail
            case .underLine(let style, let color):
                if let _style = style {
                    attributes[NSAttributedString.Key.underlineStyle] = _style.rawValue
                }
                if let _color = color {
                    attributes[NSAttributedString.Key.underlineColor] = _color
                }
            }
        }
        // fix
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        
        attributes[NSAttributedString.Key.font] = textFont
        
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
}

extension NSMutableAttributedString {
    public func appending(_ attr: NSAttributedString) -> NSMutableAttributedString {
        self.append(attr)
        return self
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
