//
//  HomeView.swift
//  Vladyslav Prosianyk BMI
//
//  Created by Vladyslav Prosianyk on 14.10.2021.
//

import UIKit

public let gradientColors = [0x19769F.hexColor, 0x31CBA5.hexColor]

class HomeView: UIViewController {
    
    var router: RouterProtocol?
    
    @IBOutlet weak var bgPickerView: UIView!
    @IBOutlet weak var pvDetails: UIPickerView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var btnCalc: UIButton!
    @IBOutlet weak var statusBarBg: UIView!
    @IBOutlet weak var statusBarBgHeight: NSLayoutConstraint!
    
    //Index Katle = (Weight) / (Height)²
    
    let weightRange = 1...200
    let heightRange = 1...300
    let genders = ["Male", "Famale"]
    
    var selectedHeight = 0
    var selectedWeight = 0
    var selectedGender = 0

    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.pvDetails.delegate = self
        self.pvDetails.dataSource = self
        
        setupUI()
    }
    
    func setupUI() {
        setupShadows()
        setupNavBar()
        setupBtn()
    }
    
    func setupBtn() {
        self.btnCalc.addGradient(colors: gradientColors, startPoint: .zero, endPoint: CGPoint(x: 1, y: 0))
        self.btnCalc.layer.masksToBounds = true
        self.btnCalc.layer.cornerRadius = 10
    }
    
    func setupShadows() {
        self.bgPickerView.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.bgPickerView.layer.shadowOpacity = 1
        self.bgPickerView.layer.shadowOffset = .zero
        self.bgPickerView.layer.shadowRadius = 7

    }
    
    func setupNavBar() {
        self.title = "Add BMI Details"
        self.statusBarBg.addGradient(colors: gradientColors)
        self.statusBarBgHeight.constant = self.statusBarHeight
        
        let opaqueView = UIView(frame: statusBarBg.frame)
        opaqueView.alpha = 0.2
        opaqueView.backgroundColor = .black
        statusBarBg.addSubview(opaqueView)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(patternImage: CAGradientLayer(gradientColors, self.navigationController?.navigationBar.frame ?? CGRect()).toImage)
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ]

    }
    
    func calculateDMI() -> Double {
        return (Double(self.selectedWeight) / pow((Double(self.selectedHeight)/100), 2))
    }
    
    func calculatePonderal() -> Double {
        return (Double(self.selectedWeight) / pow((Double(self.selectedHeight)/100.0), 3))
    }

    @IBAction func calcBtnTapped(_ sender: UIButton) {
        if self.selectedHeight > 0 && self.selectedGender > 0 && self.selectedWeight > 0 {
            self.router?.openResult(dmiRes: calculateDMI(), ponderalRes: calculatePonderal(), userName: (self.tfName.text?.isEmpty ?? true) ? "Anonymous" : self.tfName.text ?? "")
        } else {
            self.bgPickerView.layer.shadowColor = UIColor.red.cgColor
        }
    }
}

extension HomeView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
//        pickerView.subviews[1].isHidden = true
        
        switch component {
        case 0, 1:
            return row == 0 ? component == 0 ? "Select" : "Select" : "\(row)"
        case 2:
            return row == 0 ? "Select" : genders[row-1]
        default:
            return "?"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            self.selectedWeight = row
        case 1:
            self.selectedHeight = row
        case 2:
            self.selectedGender = row
        default:
            return
        }
    }
}

extension HomeView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return weightRange.count + 1
        case 1:
            return heightRange.count + 1
        case 2:
            return genders.count + 1
        default:
            return 1
        }
    }
    
    
}

