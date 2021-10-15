//
//  ResultView.swift
//  Vladyslav Prosianyk BMI
//
//  Created by Vladyslav Prosianyk on 14.10.2021.
//

import UIKit
import GoogleMobileAds

class ResultView: UIViewController {

    
    var router: RouterProtocol?
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var statusBarBg: UIView!
    @IBOutlet weak var statusBarBgHeight: NSLayoutConstraint!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var lblBmiNumber: UILabel!
    @IBOutlet weak var lblResultTitle: UILabel!
    @IBOutlet weak var lblPonderalIndex: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var rateBtn: UIButton!
    
    var dmiResult: Double = 0.0
    var ponderalIndex: Double = 0.0
    var userName = "Anonymous"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ kGADSimulatorID ]

        setupUI()
    }
    
    func setupUI() {
        setupBanner()
        setupNavBar()
        setupResView()
    }
    
    func setupBanner() {
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-6699887723216638/9283700409"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func setupNavBar() {
        self.title = "BMI Details"
        self.statusBarBg.addGradient(colors: gradientColors)
        self.statusBarBgHeight.constant = self.statusBarHeight
        
        let opaqueView = UIView(frame: statusBarBg.frame)
        opaqueView.alpha = 0.2
        opaqueView.backgroundColor = .black
        statusBarBg.addSubview(opaqueView)
        
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationItem.backButtonTitle = ""
    }
    
    func setupResView() {
        self.resultView.addGradient(colors: gradientColors, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1))
        self.resultView.layer.cornerRadius = 15
        
        let resText: String = {
            switch dmiResult {
            case 18...25 :
                return "normal"
            case ...18 :
                return "underweight, please correct your diet"
            case 25... :
                return "overweight, go in for sports"
            default:
                return ""
            }
        }()
        
        self.lblResultTitle.text = "Hello \(userName), you are \(resText)"
        self.lblBmiNumber.attributedText = "\(Int(dmiResult))".attributedString(font: .systemFont(ofSize: 100), color: .white, alignment: .center).appending(" . ".attributedString(font: .systemFont(ofSize: 40), color: .white, alignment: .center).appending("\(Int((dmiResult - Double(Int(dmiResult))) * 100))".attributedString(font: .systemFont(ofSize: 40), color: .white, alignment: .center)))
        self.lblPonderalIndex.text = "Ponderal Index: \(ponderalIndex.format(f: "0.2"))kg/m3"
        
        self.rateBtn.layer.cornerRadius = 10
        self.rateBtn.layer.borderColor = UIColor.white.cgColor
        self.rateBtn.layer.borderWidth = 1
        
        self.shareBtn.layer.cornerRadius = 10
        self.shareBtn.layer.borderColor = UIColor.white.cgColor
        self.shareBtn.layer.borderWidth = 1
    }
    
    func openShareScreen() {
        let share = UIActivityViewController(activityItems: [self.resultView.asImage()], applicationActivities: nil)
        self.present(share, animated: true, completion: nil)
    }
    @IBAction func shareTapped(_ sender: UIButton) {
        self.openShareScreen()
    }
    
}

extension ResultView: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      bannerView.alpha = 0
      UIView.animate(withDuration: 1, animations: {
        bannerView.alpha = 1
      })
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
    
}
