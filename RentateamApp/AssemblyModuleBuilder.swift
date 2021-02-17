//
//  ModuleBuilder.swift
//  RentateamApp
//
//  Created by Ildar on 2/15/21.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailedPhotoModule(photo: Photo, router: RouterProtocol) -> UIViewController
    func createDetailedPhotoModuleCore(photo: PhotoCoreData, router: RouterProtocol) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let network = NetworkService()
        let coreData = CoreDataPhoto()
        let view = PhotoTableViewController()
        let presenter = PhotoPresenter(view: view,networkService: network, router: router, coreDataService: coreData)
        view.presenter = presenter
        return view
    }
    
    func createDetailedPhotoModule(photo: Photo, router: RouterProtocol) -> UIViewController {
        let view = DetailedPhotoViewController()
        let presenter = DetailedPhotoPresenter(view: view,router: router, photo: photo)
        view.presenter = presenter
        return view
    }
    
    func createDetailedPhotoModuleCore(photo: PhotoCoreData, router: RouterProtocol) -> UIViewController {
        let view = DetailedPhotoViewController()
        let presenter = DetailedPhotoPresenter(view: view,router: router, photo: photo)
        view.presenter = presenter
        return view
    }
}
