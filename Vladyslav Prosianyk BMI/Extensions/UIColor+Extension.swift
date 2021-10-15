//
//  UIColor+Extension.swift
//  Vladyslav Prosianyk BMI
//
//  Created by Vladyslav Prosianyk on 14.10.2021.
//

import UIKit

extension Int {
    var hexColor: UIColor {
        return UIColor(red:CGFloat((self & 0xFF0000) >> 16) / 255 , green: CGFloat((self & 0x00FF00) >> 8) / 255, blue: CGFloat((self & 0x0000FF) ) / 255, alpha: 1.0)
    }
}


extension CALayer {
    var toImage: UIImage {
            UIGraphicsBeginImageContextWithOptions(frame.size, isOpaque, 0)
            render(in: UIGraphicsGetCurrentContext()!)
            let fin = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return fin ?? UIImage()
    }
}

extension CAGradientLayer {
    convenience init(_ colors: [UIColor], _ frame: CGRect = CGRect.init(x: 0, y: 0, width: 1, height: 1)) {
        self.init()
        self.frame = frame
        self.colors =  colors.map{$0.cgColor}
        self.startPoint = CGPoint.init(x: 0, y: 0)
        self.endPoint = CGPoint.init(x: 1, y: 0)
    }
}
