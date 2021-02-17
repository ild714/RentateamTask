//
//  PhotoTableViewCell.swift
//  RentateamApp
//
//  Created by Ildar on 2/15/21.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoName: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    func configure(text: String, url: String) {
        photo.layer.cornerRadius = 75
        
        self.photoName.text = text
        self.photo.sd_setImage(with: URL(string: url), completed: nil)
    }
    func configureCore(text: String, data: Data) {
        photo.layer.cornerRadius = 75
        
        self.photoName.text = text
        self.photo.image = UIImage(data: data)
    }
}

