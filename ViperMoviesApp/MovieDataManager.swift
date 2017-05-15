//
//  PopularDataManager.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 03.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation
import SDWebImage


class MovieDataManager: MovieDataManagerProtocol {
    
    struct MovieAPI {
        static let moviesUrl = "\(MovieURL.MovieURL)movie/"
        static let moviesUrlP2 = "\(APIKey.APIKey)&page="
    }
    
    struct MovieSearchAPI {
        static let searchUrl = "\(MovieURL.MovieURL)search/movie\(APIKey.APIKey)&query="
    }
    
    func downloadDataFromInternetAndParseJSON(movieType: String, page: Int, closure: @escaping (NSError?,[MovieModel]?) -> Void) -> Void {
        let mainUrl = URL(string: "\(MovieAPI.moviesUrl)\(movieType)\(MovieAPI.moviesUrlP2)\(page)")!
        let request = URLRequest(url: mainUrl)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { closure(error as NSError, nil) }
            if let data = data {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.convertData(data: data, closure: { (error, movies) in
                        closure(error, movies)
                    })
                }
            } 
        }
        session.resume()
    }
    
    func downloadDataFromSearchTextAndParseJSON(searchText: String, closure: @escaping (NSError?, [MovieModel]?) -> Void) -> Void {
        let replacingText = searchText.replacingOccurrences(of: " ", with: "%20")
        let mainUrl = URL(string: "\(MovieSearchAPI.searchUrl)\(replacingText)&page=1")!
        let request = URLRequest(url: mainUrl)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { closure(error as NSError, nil) }
            if let data = data {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.convertData(data: data, closure: { (error, movies) in
                        closure(error, movies)
                    })
                }
            }
        }
        session.resume()
    }
    
    private func convertData(data: Data, closure: @escaping (NSError?,[MovieModel]?) -> Void) -> Void {
        do {
            let jsonResults = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            guard let results = jsonResults["results"] as? [[String:AnyObject]] else {return}
            let moviesModel = results.map({ (resultDictionary) -> MovieModel in
                let posterPath = resultDictionary["poster_path"] as? String ?? ""
                let overview = resultDictionary["overview"] as? String ?? ""
                let title = resultDictionary["title"] as? String ?? ""
                let vote = resultDictionary["vote_average"] as? Double ?? 0.0
                let id = resultDictionary["id"] as? Int ?? 0
                
                let popularMovie = MovieModel(posterPath: posterPath, overview: overview, title: title, vote: vote, id: id)
                return popularMovie
            })
            closure(nil, moviesModel)
        } catch {
            closure(error as NSError?, nil)
        }
    }
    
    func loadImageFromURL(_ url: NSURL, closure: @escaping(UIImage?, NSError?) -> Void) {
        SDWebImageManager.shared().imageDownloader!.downloadImage(with: url as URL, options: .useNSURLCache, progress: nil, completed: { (image, cache, error, finished) in
            if ((image != nil) && finished) {
                closure(image, error as NSError?)
            }
        })
    }
    
    
}
