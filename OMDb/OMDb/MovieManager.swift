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
    let apiKey = ""
    
    var movieList = [Movie]()
    
    private init() {
        
    }
    
    func getMovies(name: String) {
        
        let path = "http://www.omdbapi.com/?s=\(name)&r=json&page=1"
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
                    
                    self.movieList.removeAll()
                    
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        
                        if let list = json["Search"] as? [[String: AnyObject]] {
                            print(list)
                            for item in list {
                                let movie = Movie()
                                movie.title = item["Title"] as? String
                                movie.year = item["Year"] as? String
                                movie.id = item["imdbID"] as? String
                                
                                self.movieList.append(movie)
                                
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    NSNotificationCenter.defaultCenter().postNotificationName("didAddMovie", object: self)
                                })
                            }
                            
                        }
                        
                    } catch {
                        print("Erro JSON")
                    }
                }
            }
        }
        task.resume()
    }
    
    func getMovieDescription(movie: Movie) {
        
        let path = "http://www.omdbapi.com/?i=\(movie)&plot=short&r=json"
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
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        
                        print(json)
                
                        if let list = json as? [String: AnyObject] {
                            movie.plot = list["Plot"] as? String
                            movie.director = list["Director"] as? String
                            movie.genre = list["Genre"] as? String
                            movie.language = list["Language"] as? String
                            movie.country = list["Country"] as? String
                                
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                NSNotificationCenter.defaultCenter().postNotificationName("didUpdateMovie", object: self)
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
