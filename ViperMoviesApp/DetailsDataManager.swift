//
//  DetailsDataManager.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 04.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation


class DetailsDataManager: DetailsDataManagerProtocol {
    
    struct VideoAPI {
        static let videoURL = "\(MovieURL.MovieURL)movie/"
        static let videoURLP2 = "/videos\(APIKey.APIKey)"
    }
    
    struct DetailAPI {
        static let detailURL = VideoAPI.videoURL
        static let detailURLP2 = APIKey.APIKey
    }
    
    struct CastAPI {
        static let castURL = VideoAPI.videoURL
        static let castURLP2 = "/credits\(APIKey.APIKey)"
    }
    
    func downloadVideoKeyMovie(id: Int, closure:@escaping (NSError?, VideoModel?) -> Void) -> Void {
        let mainURL = URL(string: "\(VideoAPI.videoURL)\(id)\(VideoAPI.videoURLP2)")!
        let request = URLRequest(url: mainURL)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { closure(error as NSError, nil) }
            if let data = data {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.convertVideoKeyData(data: data, closure: { (error, videoModel) in
                        closure(error, videoModel)
                    })
                }
            }
        }
        session.resume()
    }
    
    private func convertVideoKeyData(data: Data, closure:@escaping (NSError?, VideoModel?) -> Void) {
        do {
            let resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            guard let results = resultDictionary["results"] as? [[String:AnyObject]] else { return }
            if results.count >= 1 {
                let videoKey = results[0]["key"] as? String
                let videoObj = VideoModel(videoKey: videoKey!)
                closure(nil, videoObj)
            }
        } catch {
            closure(error as NSError, nil)
        }
    }
    
    func downloadMovieDetails(movieId: Int, closure: @escaping(NSError?, MovieModel?) -> Void) -> Void {
        let mainURL = URL(string: "\(DetailAPI.detailURL)\(movieId)\(DetailAPI.detailURLP2)")!
        let request = URLRequest(url: mainURL)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { closure(error as NSError, nil) }
            if let data = data {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.convertDetailMovieData(data: data, closure: { (error, movieModel) in
                        closure(error, movieModel)
                    })
                }
            }
        }
        session.resume()
    }
    
    private func convertDetailMovieData(data: Data, closure: @escaping(NSError?, MovieModel?) -> Void) {
        do {
            var type1: String
            var type2: String
            var production1: String
            var production2: String
            var category: String = "Not given"
            var production: String = "Not given"
            
            let resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            let releaseDate = resultDictionary["release_date"] as? String ?? ""
            let runtime = resultDictionary["runtime"] as? Int ?? 0
            let tagline = resultDictionary["tagline"] as? String ?? ""
            let revenue = resultDictionary["revenue"] as? Int ?? 0
            let duration = "\(runtime) minutes"
            let boxofficeFormatter = String(revenue.stringFormattedWithSeparator)
            let boxoffice = "$\(boxofficeFormatter!)"
            
            if let genres = resultDictionary["genres"] as? [[String:AnyObject]], genres.count >= 2  {
                type1 = genres[0]["name"] as? String ?? ""
                type2 = genres[1]["name"] as? String ?? ""
                category = "\(type1)\(", ")\(type2)"
            }
            
            if let productions = resultDictionary["production_countries"] as? [[String:AnyObject]], productions.count >= 2 {
                production1 = productions[0]["iso_3166_1"] as? String ?? ""
                production2 = productions[1]["iso_3166_1"] as? String ?? ""
                production = "\(production1)\(", ")\(production2)"
            }
            
            let movieObj = MovieModel(boxoffice: boxoffice, duration: duration, tagline: tagline, releaseDate: releaseDate, category: category, production: production)
            
            closure(nil, movieObj)
            
        } catch {
            closure(error as NSError, nil)
        }
    }
    
    
    func downloadMovieCast(movieId: Int, closure: @escaping (NSError?, [ActorModel]?) -> Void) -> Void {
        let mainURL = URL(string: "\(CastAPI.castURL)\(movieId)\(CastAPI.castURLP2)")!
        let request = URLRequest(url: mainURL)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { closure(error as NSError, nil) }
            
            if let data = data {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.convertCastData(data: data, closure: { (error, casts) in
                        closure(error, casts)
                    })
                }
            }
        }
        session.resume()
    }
    
    
    private func convertCastData(data: Data, closure: @escaping (NSError?, [ActorModel]?) -> Void) {
        do {
            var actorsArray: [ActorModel] = []
            let resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            guard let casts = resultDictionary["cast"] as? [[String:AnyObject]] else { return }
            if casts.count >= 10 {
                for index in 0..<10 {
                    let castObj = self.parseCastDataToJSON(casts: casts, index: index)
                    actorsArray.append(castObj)
                }
            } else {
                for index in 0..<casts.count {
                    let castObj = self.parseCastDataToJSON(casts: casts, index: index)
                    actorsArray.append(castObj)
                }
            }

            closure(nil, actorsArray)
            
        } catch {
            closure(error as NSError?, nil)
        }
    }
    
    private func parseCastDataToJSON(casts: [[String:AnyObject]], index: Int) -> ActorModel {
        let character = casts[index]["character"] as? String ?? ""
        let actorId = casts[index]["id"] as? Int ?? 0
        let name = casts[index]["name"] as? String ?? ""
        let profilePath = casts[index]["profile_path"] as? String ?? ""
        let castObj = ActorModel(actorCharacter: character, actorId: actorId, actorName: name, actorPathUrl: profilePath)
        return castObj
    }
    
}






