//
//  PhotoDb+CoreDataProperties.swift
//  RentateamApp
//
//  Created by Ildar on 2/17/21.
//
//

import Foundation
import CoreData


extension PhotoDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoDb> {
        return NSFetchRequest<PhotoDb>(entityName: "PhotoDb")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var url: Data?

}
