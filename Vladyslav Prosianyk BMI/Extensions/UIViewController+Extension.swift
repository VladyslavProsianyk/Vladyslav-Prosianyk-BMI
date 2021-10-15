//
//  UIViewController+Extension.swift
//  Vladyslav Prosianyk BMI
//
//  Created by Vladyslav Prosianyk on 15.10.2021.
//

import Foundation
import UIKit

extension UIViewController {
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.size.height ?? 0
    }
    
}
