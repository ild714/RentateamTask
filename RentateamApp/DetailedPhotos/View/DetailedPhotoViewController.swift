//
//  DetailedPhotoViewController.swift
//  RentateamApp
//
//  Created by Ildar on 2/16/21.
//

import UIKit
import SDWebImage

class DetailedPhotoViewController: UIViewController {
    @IBOutlet weak var photoImage: UIImageView!
    
    var presenter: DetailedPhotoPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.setPhoto()
    }
}

extension DetailedPhotoViewController: DetailedPhotoViewProtocol {
    func setPhoto(photo: Photo?) {
        if let photo = photo {
            photoImage.sd_setImage(with: URL(string: photo.url), completed: nil)
        }
    }
}
