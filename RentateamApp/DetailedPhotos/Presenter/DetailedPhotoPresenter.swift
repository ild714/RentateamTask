//
//  DetailedPhotoPresenter.swift
//  RentateamApp
//
//  Created by Ildar on 2/16/21.
//

import Foundation

protocol DetailedPhotoViewProtocol: class {
    func setPhoto(photo: Photo?)
}

protocol DetailedPhotoViewPresenterProtocol: class {
    init(view: DetailedPhotoViewProtocol,router: RouterProtocol, photo: Photo)
    func setPhoto()
}

class DetailedPhotoPresenter: DetailedPhotoViewPresenterProtocol {
    weak var view: DetailedPhotoViewProtocol?
    var photo: Photo?
    var router: RouterProtocol?
    
    required init(view: DetailedPhotoViewProtocol,router:RouterProtocol, photo: Photo) {
        self.view = view
        self.photo = photo
        self.router = router
    }
    
    public func setPhoto() {
        self.view?.setPhoto(photo: photo)
    }
}
