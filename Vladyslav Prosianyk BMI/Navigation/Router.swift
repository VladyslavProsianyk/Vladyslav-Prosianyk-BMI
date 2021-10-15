//
//  Router.swift
//  Vladyslav Prosianyk BMI
//
//  Created by Vladyslav Prosianyk on 14.10.2021.
//

import Foundation
import UIKit

protocol BaseRouterProtocol {
    var navController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: BaseRouterProtocol {
    func initSplash()
    func initHome()
    func openResult(dmiRes: Double, ponderalRes: Double, userName: String)
}

class Router: RouterProtocol {
    
    var navController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navController = navController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initSplash() {
        if let navController = navController {
            guard let splash = assemblyBuilder?.createSplashModule(router: self) else { return }
            navController.viewControllers = [splash]
        }
    }
    
    func initHome() {
        if let navController = navController {
            guard let home = assemblyBuilder?.createHomeModule(router: self) else { return }
            navController.viewControllers = [home]
        }
    }
    
    func openResult(dmiRes: Double, ponderalRes: Double, userName: String) {
        if let navController = navController {
            guard let result = assemblyBuilder?.createResultModule(router: self, dmiRes: dmiRes, ponderalRes: ponderalRes, userName: userName) else { return }
            navController.pushViewController(result, animated: true)
        }
    }

}
