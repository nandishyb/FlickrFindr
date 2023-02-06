//
//  FlickrSearchDataProvider.swift
//  FlickrFindr
//
//  Created by Nandish Bellad on 02/02/2023.
//

import Foundation

class FlickrSearchDataProvider {
    
    static let FlickrApiKey = "1508443e49213ff84d566777dc211f2a"
    static var FlickrPhotos:[Photo] = [Photo]()
    
    class func retrivePhotosForSearchTerm(searchTerm:String, completion : @escaping (([Photo]? , Error?)->())) {
        let escapedSearchTerm: String = searchTerm.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
//          let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(FlickrApiKey)&tags=\(escapedSearchTerm)&per_page=25&format=json&nojsoncallback=1"
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(FlickrApiKey)&text=\(escapedSearchTerm)&per_page=25&format=json&nojsoncallback=1"
        guard let url = URL(string: urlString) else {
            NSLog("Error : Url is Nil !!")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            NSLog("data :\(String(describing: data))")
            
            if let error = error {
                NSLog("error :\(error)")
                completion(nil, error)
                return
            }
            NSLog("response :\(String(describing: response))")
    
            if let data = data {
                let dataString = String(data: data , encoding: .ascii)
                //NSLog("dataString :\(String(describing: dataString))")
                
                if let jsonPhotos = try? JSONDecoder().decode(FPhotos.self, from: data) {
                    completion(jsonPhotos.photos.photo, nil)
                } else {
                    NSLog("Error : jsonPhotos is nil")
                    let jError = NSError(domain: "Json Parse Error", code: -1)
                    completion(nil, jError)
                }
            } else {
                NSLog("Error : data is nil")
                let dError = NSError(domain: "Data is nil", code: -2)
                completion(nil, dError)
            }
        }
        task.resume()
    }
}
