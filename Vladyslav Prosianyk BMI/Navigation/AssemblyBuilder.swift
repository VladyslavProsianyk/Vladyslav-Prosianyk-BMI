//
//  AssemblyBuilder.swift
//  Vladyslav Prosianyk BMI
//
//  Created by Vladyslav Prosianyk on 14.10.2021.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createSplashModule(router: RouterProtocol) -> UIViewController
    func createHomeModule(router: RouterProtocol) -> UIViewController
    func createResultModule(router: RouterProtocol, dmiRes: Double, ponderalRes: Double, userName: String) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createSplashModule(router: RouterProtocol) -> UIViewController {
        let view = SplashView()
        view.router = router
        return view
    }
    
    func createHomeModule(router: RouterProtocol) -> UIViewController {
        let view = HomeView()
        view.router = router
        return view
    }
    
    func createResultModule(router: RouterProtocol, dmiRes: Double, ponderalRes: Double, userName: String) -> UIViewController {
        let view = ResultView()
        view.userName = userName
        view.ponderalIndex = ponderalRes
        view.dmiResult = dmiRes
        view.router = router
        return view
    }
    
}
