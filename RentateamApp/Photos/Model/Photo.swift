//
//  Image.swift
//  RentateamApp
//
//  Created by Ildar on 2/15/21.
//

import UIKit

struct Photo: Codable {
    var id: Int
    let title: String
    let url: String
}

struct PhotoCoreData: Codable {
    var id: Int
    let title: String
    let data: Data
}
