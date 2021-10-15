//
//  UIView+Extension.swift
//  Vladyslav Prosianyk BMI
//
//  Created by Vladyslav Prosianyk on 14.10.2021.
//

import UIKit

extension UIView {
    func addGradient(colors: [UIColor], startPoint: CGPoint = .zero, endPoint: CGPoint = CGPoint(x: 1, y: 0)) {
        let gradient = CAGradientLayer(colors, self.frame)
        gradient.endPoint = endPoint
        gradient.startPoint = startPoint
        let imageGradient = gradient.toImage.withRenderingMode(.alwaysTemplate)
        self.backgroundColor = UIColor(patternImage: imageGradient)
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

