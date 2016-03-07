//
//  TableViewController.swift
//  OMDb
//
//  Created by Mariana Alvarez on 04/03/16.
//  Copyright © 2016 Mariana Alvarez. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {

    let manager = MovieManager.sharedInstance
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reloadData"), name: "didAddMovie", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    @IBAction func logout(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.manager.movieList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        let movie = self.manager.movieList[indexPath.row]
        
        cell.textLabel!.text = movie.title
        cell.detailTextLabel!.text = movie.year

        return cell
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    // MARK: - Search bar data source

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            // Substituindo caracteres especiais por %
            let newString = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            manager.getMovies(newString!)
        }
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let cell = sender as! UITableViewCell
            let indexPath: NSIndexPath = self.tableView.indexPathForCell(cell)!
            
            if manager.movieList[indexPath.row].director != nil {
                let destView = segue.destinationViewController as! DetailViewController
                destView.movie = manager.movieList[indexPath.row]
            } else {
                self.manager.getMovieInfo(manager.movieList[indexPath.row])
            }
        }
    }

}
