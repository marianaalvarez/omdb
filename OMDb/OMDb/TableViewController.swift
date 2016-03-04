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
        self.dismissViewControllerAnimated(false, completion: nil)
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

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            manager.getMovies(searchBar.text!)
        }
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

}
