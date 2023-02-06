//
//  FlickrFindrViewModel.swift
//  FlickrFindr
//
//  Created by Nandish Bellad on 02/02/2023.
//

import Foundation
import Combine

protocol FlickrFindrViewModelProtocol {
    var photos:[Photo] { get }
    func fetchPhotos(searchTerm:String)
}

final class FlickrFindrViewModel : ObservableObject {
    @Published var photos = [Photo]()
    @Published var fetchError:NSError?

    init(searchTerm:String = "") {
        if !searchTerm.isEmpty {
            fetchPhotos(searchTerm: searchTerm)
        }
    }
}

extension FlickrFindrViewModel : FlickrFindrViewModelProtocol {
    func fetchPhotos(searchTerm: String) {
        if !searchTerm.isEmpty  {
            FlickrSearchDataProvider.retrivePhotosForSearchTerm(searchTerm: searchTerm, completion: { photos, error in
                if let photos = photos {
                    DispatchQueue.main.async {
                        self.photos = photos
                    }
                } else {
                    NSLog("Error : in retrivePhotosForSearchTerm ")
                    DispatchQueue.main.async {
                        self.fetchError = error! as NSError
                    }
                }
            })
        } else {
            self.photos.removeAll()
        }
    }
}

