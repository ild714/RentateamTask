//
//  DetailedPhotoPresenter.swift
//  RentateamApp
//
//  Created by Ildar on 2/16/21.
//

import Foundation

protocol DetailedPhotoViewProtocol: class {
    func setPhoto(photo: Photo?)
    func setPhotoCore(photo: PhotoCoreData?)
}

protocol DetailedPhotoViewPresenterProtocol: class {
    init(view: DetailedPhotoViewProtocol,router: RouterProtocol, photo: Photo)
    func setPhoto()
}

class DetailedPhotoPresenter: DetailedPhotoViewPresenterProtocol {
    weak var view: DetailedPhotoViewProtocol?
    var photo: Photo?
    var photoCore: PhotoCoreData?
    var router: RouterProtocol?
    
    required init(view: DetailedPhotoViewProtocol,router:RouterProtocol, photo: Photo) {
        self.view = view
        self.photo = photo
        self.router = router
    }
    
    required init(view: DetailedPhotoViewProtocol,router:RouterProtocol, photo: PhotoCoreData) {
        self.view = view
        self.photoCore = photo
        self.router = router
    }
    
    public func setPhoto() {
        self.view?.setPhoto(photo: photo)
    }
    public func setPhotoCore() {
        self.view?.setPhotoCore(photo: photoCore)
    }
}
