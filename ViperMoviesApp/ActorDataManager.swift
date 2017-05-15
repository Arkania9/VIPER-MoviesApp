//
//  ActorDataManager.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 06.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation


class ActorDataManager: ActorDataManagerProtocol {
    
    struct ActorAPI {
        static let actorURL = "\(MovieURL.MovieURL)person/"
        static let actorURLP2 = "\(APIKey.APIKey)"
    }
    
    struct ActorMoviesAPI {
        static let actorMoviesURL = "\(MovieURL.MovieURL)find/"
        static let actorMoviesURLP2 = "\(APIKey.APIKey)&external_source=imdb_id"
    }
    
    func downloadActorDetailsFromInternet(actorId: Int, closure:@escaping (NSError?, ActorModel?) -> Void) -> Void {
        let mainURL = URL(string: "\(ActorAPI.actorURL)\(actorId)\(ActorAPI.actorURLP2)")!
        let request = URLRequest(url: mainURL)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { closure(error as NSError?, nil) }
            if let data = data {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.convertDataToActorDetailsModel(data: data, closure: { (error, actor) in
                        closure(error, actor)
                    })
                }
            }
        }
        session.resume()
    }
    
    private func convertDataToActorDetailsModel(data: Data, closure: @escaping(NSError?, ActorModel?) -> Void) {
        do {
            let resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            let biography = resultDictionary["biography"] as? String ?? ""
            var birthday = resultDictionary["birthday"] as? String ?? ""
            let placeOfBirth = resultDictionary["place_of_birth"] as? String ?? "Not given"
            let imdbId = resultDictionary["imdb_id"] as? String ?? ""
            let actorAge = getCurrentActorYears(birthday: birthday)
            birthday = "\(birthday)\(actorAge)"
            let actorObj = ActorModel(biography: biography, birthday: birthday, placeOfBirth: placeOfBirth, imdbId: imdbId)
            closure(nil, actorObj)
            
        } catch {
            closure(error as NSError?, nil)
        }
    }
    
    private func getCurrentActorYears(birthday: String) -> String {
        let now = NSDate()
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if birthday != "" {
            let actorBirthdayFormat = dateFormatter.date(from: birthday)
            let actorAgeComponents = calendar.components(.year, from: actorBirthdayFormat!, to: now as Date, options: [])
            let actorAge = actorAgeComponents.year
            return String(" (\(actorAge!)) years")
        }
        return "Not given"
    }
    
    func downloadFamousMoviesForTheActor(imdbId: String, closure: @escaping(NSError?, [MovieModel]?) -> Void) -> Void {
        let mainURL = URL(string: "\(ActorMoviesAPI.actorMoviesURL)\(imdbId)\(ActorMoviesAPI.actorMoviesURLP2)")!
        let request = URLRequest(url: mainURL)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { closure(error as NSError?, nil) }
            if let data = data {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.convertDataForActorFamousMovies(data: data, closure: { (error, movies) in
                        closure(error, movies)
                    })
                }
            }
        }
        session.resume()
    }
    
    private func convertDataForActorFamousMovies(data:Data, closure: @escaping(NSError?, [MovieModel]?) -> Void) {
        do {
            let resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
            guard let personResults = resultDictionary["person_results"] as? [[String:AnyObject]] else { return }
            guard let actorMovies = personResults[0]["known_for"] as? [[String:AnyObject]] else { return }
            let famousMovies = actorMovies.map({ (moviesDictionary) -> MovieModel in
                let title = moviesDictionary["title"] as? String ?? ""
                let releaseDate = moviesDictionary["release_date"] as? String ?? ""
                let posterPath = moviesDictionary["poster_path"] as? String ?? ""
                let movieId = moviesDictionary["id"] as? Int ?? 0
                let vote = moviesDictionary["vote"] as? Double ?? 0.0
                let overview = moviesDictionary["overview"] as? String ?? ""
                let famousMovieObj = MovieModel(title: title, releaseDate: releaseDate, posterPath: posterPath, movieId: movieId, vote: vote, overview: overview)
                return famousMovieObj
            })
            closure(nil, famousMovies)
        } catch {
            closure(error as NSError, nil)
        }
    }
    
}
