//
//  Photos.swift
//  FlickrFindr
//
//  Created by Nandish Bellad on 02/02/2023.
//

import Foundation

struct FPhotos : Codable {
    var photos:Photos
}
struct Photos : Codable {
    var photo:[Photo]
}

struct Photo : Codable , Identifiable {
    var id: String
    var secret:String
    var server:String
    var farm:Int
    var title:String
    
    var photoUrl:URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}
