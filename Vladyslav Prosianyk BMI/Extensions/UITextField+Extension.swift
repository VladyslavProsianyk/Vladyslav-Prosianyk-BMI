//
//  UITextField+Extension.swift
//  Vladyslav Prosianyk BMI
//
//  Created by Vladyslav Prosianyk on 15.10.2021.
//

import Foundation
import UIKit

extension UITextField{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        flexSpace.tintColor = .black
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        done.tintColor = .black

        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar

    }

    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
