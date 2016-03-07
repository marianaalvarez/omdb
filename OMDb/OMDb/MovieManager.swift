//
//  MovieManager.swift
//  OMDb
//
//  Created by Mariana Alvarez on 04/03/16.
//  Copyright © 2016 Mariana Alvarez. All rights reserved.
//

import UIKit

class MovieManager {
    
    static let sharedInstance = MovieManager()
    
    var movieList = [Movie]()
    
    private init() {}
    
    func getMovies(title: String) {
        
        // Busca de filmes por título
        let path = "http://www.omdbapi.com/?s=\(title)&r=json"
        let url = NSURL(string: path)
        let jsonData = NSData(contentsOfURL: url!)

        self.movieList.removeAll()
                    
        do {
            // Desserialização dos dados JSON
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
            
            // Verifica se a busca não retornou nulo
            if let list = json["Search"] as? [[String: AnyObject]] {
                for item in list {
                    let movie = Movie()
                    movie.title = item["Title"] as? String
                    movie.year = item["Year"] as? String
                    movie.id = item["imdbID"] as? String
                                
                    self.movieList.append(movie)
                }
                            
            }
            // Atualiza interface
            NSNotificationCenter.defaultCenter().postNotificationName("didAddMovie", object: self)
                        
        } catch {
            print("Erro JSON")
        }
    }

    
    
    func getMovieInfo(movie: Movie) {
        
        // Busca de filme imdbId
        let path = "http://www.omdbapi.com/?i=\(movie.id)&plot=long&r=json"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            
            if error != nil {
                print("erro")
            }
            
            if let httpResponse = response  as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("Erro HTTPResponse")
                } else   {
                    
                    do {
                        // Desserialização dos dados JSON
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                
                        if let list = json as? [String: AnyObject] {
                            movie.plot = list["Plot"] as? String
                            movie.director = list["Director"] as? String
                            movie.genre = list["Genre"] as? String
                            movie.language = list["Language"] as? String
                            movie.country = list["Country"] as? String
                            movie.runtime = list["Runtime"] as? String
                            movie.poster = list["Poster"] as? String
                            
                            // Atualiza interface
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                let userInfo = ["movie": movie]
                                NSNotificationCenter.defaultCenter().postNotificationName("didUpdateMovie", object: self, userInfo: userInfo)
                                })
                        }
                    } catch {
                        print("Erro JSON")
                    }
                }
            }
        }
        task.resume()
    }
}
