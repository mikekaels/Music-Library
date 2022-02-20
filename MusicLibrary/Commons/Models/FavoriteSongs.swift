//
//  FavoriteSongs.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 20/02/22.
//

import Foundation
import CoreData

@objc(FavoriteSongs)
class FavoriteSongs: NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var songTitle: String!
    @NSManaged var singer: String!
    @NSManaged var dateAdded: Date?
    @NSManaged var saved: NSNumber?
}

struct SongsModel {
    let id: NSNumber
    let songTitle: String
    let singer: String
    let dateAdded: Date
    let saved: NSNumber
}
