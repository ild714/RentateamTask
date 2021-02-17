//
//  ImagePresenter.swift
//  RentateamApp
//
//  Created by Ildar on 2/15/21.
//

import UIKit
import CoreData

protocol PhotoViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol PhotoViewPresenterProtocol: class {
    init(view: PhotoViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, coreDataService: CoreDataPhotoProtocol)
    func getPhotos()
    var photos: [Photo]? { get set }
    var photosCoreData: [PhotoCoreData]? { get set }
    func tapOnThePhoto(photo: Photo)
    func tapOnThePhotoCore(photo: PhotoCoreData)
    func setPhotos(photos: [PhotoCoreData])
    func fetchData() -> [PhotoCoreData]?
}

class PhotoPresenter: PhotoViewPresenterProtocol {
    weak var view: PhotoViewProtocol?
    let networkService: NetworkServiceProtocol
    let coreDataService: CoreDataPhotoProtocol
    var photos: [Photo]?
    var photosCoreData: [PhotoCoreData]?
    var router: RouterProtocol?
    
    required init(view: PhotoViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, coreDataService: CoreDataPhotoProtocol) {
        self.view = view
        self.networkService = networkService
        self.coreDataService = coreDataService
        self.router = router
        getPhotos()
    }
    
    func tapOnThePhotoCore(photo: PhotoCoreData) {
        router?.showDetailCore(photo: photo)
    }
    
    func setPhotos(photos: [PhotoCoreData]) {
        self.photosCoreData = photos
    }
    
    func fetchData() -> [PhotoCoreData]? {
        do {
            let fetchRequest: NSFetchRequest<PhotoDb> = PhotoDb.fetchRequest()
            let objects = try coreDataService.context.fetch(fetchRequest)
            
            var photos: [PhotoCoreData] = []
            for obj in objects {
                photos.append(PhotoCoreData(id: Int(obj.id), title: obj.title ?? "No string", data: obj.url ?? Data()))
            }
            return photos
        } catch {
            print("error with fetching")
            return nil
        }
    }
    
    func getPhotos() {
        networkService.getPhotos {[weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    DispatchQueue.global(qos: .userInitiated).async {
                        if let photos = photos {
                            for photo in photos {
                                let ph = PhotoDb(context: self.coreDataService.context)
                                ph.id = Int16(photo.id )
                                ph.title = photo.title
                                do {
                                    if let urlForData = URL(string: photo.url) {
                                        let imageData: Data = try Data(contentsOf: urlForData )
                                        ph.url = imageData
                                        self.coreDataService.saveContext()
                                    }
                                } catch {
                                    print("error with photo data")
                                }
                            }
                        }
                    }
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
