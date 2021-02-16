//
//  ImagePresenter.swift
//  RentateamApp
//
//  Created by Ildar on 2/15/21.
//

import UIKit

protocol PhotoViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol PhotoViewPresenterProtocol: class {
    init(view: PhotoViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getPhotos()
    var photos: [Photo]? { get set }
    func tapOnThePhoto(photo: Photo)
}

class PhotoPresenter: PhotoViewPresenterProtocol {
    weak var view: PhotoViewProtocol?
    let networkService: NetworkServiceProtocol
    var photos: [Photo]?
    var router: RouterProtocol?
    
    required init(view: PhotoViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getPhotos()
    }
    
    func getPhotos() {
        networkService.getPhotos {[weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self.photos = photos
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func tapOnThePhoto(photo: Photo) {
        router?.showDetail(photo: photo)
    }
}
