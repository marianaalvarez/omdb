//
//  ContentViewController.swift
//  OMDb
//
//  Created by Mariana Alvarez on 03/03/16.
//  Copyright © 2016 Mariana Alvarez. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var pageIndex: Int!
    var imageFile: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: self.imageFile)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
