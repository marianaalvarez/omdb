//
//  ViewController.swift
//  OMDb
//
//  Created by Mariana Alvarez on 03/03/16.
//  Copyright © 2016 Mariana Alvarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    let manager = MovieManager.sharedInstance
    
    var pageViewController: UIPageViewController!
    var pageImages: NSArray!

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        // Array de imagens
        self.pageImages = NSArray(objects: "perfume", "shutterIsland", "silenceOfTheLambs")
        
        // Instancia Page View Controller
        self.pageViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        // Retorna instância de Content View Controller
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - self.loginButton.frame.height)
    
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController {
        
        if self.pageImages.count == 0 || index >= self.pageImages.count {
            return ContentViewController()
        }
        
        let vc: ContentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        vc.imageFile = self.pageImages[index] as! String
        vc.pageIndex = index
        vc.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - self.loginButton.frame.height)
        
        return vc
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        // Pega ContentViewController atual
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index--
        
        // Retorna ContentViewController anterior
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if index == self.pageImages.count {
            return nil
        }
        
        // Retorna ContentViewController posterior
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
