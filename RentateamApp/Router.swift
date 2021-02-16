//
//  RouterProtocol.swift
//  RentateamApp
//
//  Created by Ildar on 2/16/21.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(photo: Photo)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(photo: Photo) {
        if let navigationController = navigationController {
            guard let detailedViewController = assemblyBuilder?.createDetailedPhotoModule(photo: photo, router: self) else { return }
            navigationController.pushViewController(detailedViewController, animated: true)
        }
    }
}
