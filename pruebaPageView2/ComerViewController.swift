//
//  ComerViewController.swift
//  pruebaPageView2
//
//  Created by guitarrkurt on 26/10/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class ComerViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    
    var aux = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "statusBarTitle.png")
        self.navigationItem.titleView = UIImageView(image: image)
        
        
        self.pageTitles = NSArray()
        self.pageImages = NSArray()
        
        if(aux == "bano"){
            
            self.pageTitles = NSArray(objects: "Desvistete y coloca tu ropa en el bote de la ropa sucia", "Abre la llave de paso y espera a que el agua se entibie", "Coloca champu en tu cabello y enjabona tu cuerpo", "Secate bien y usa ropa limpia")
            self.pageImages = NSArray(objects: "banar1", "banar2", "banar3", "banar4")
        }else{
            
            self.pageTitles = NSArray(objects: "Lavate las manos", "Disfruta tus alimentos", "No olvides lavar tus trastes")
            self.pageImages = NSArray(objects: "comer1", "comer2", "comer3")
        }

        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        
        let viewControllers = NSArray(object: startVC)
        
        
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        
        
        self.addChildViewController(self.pageViewController)
        
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMoveToParentViewController(self)

    }

    
    
    
    func viewControllerAtIndex(index: Int) -> ContentViewController{
        if((pageTitles == 0) || (index >= pageTitles.count)){
            return ContentViewController()
        }
        
        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        
        vc.imageFile = self.pageImages[index] as! String
        vc.titleText = self.pageTitles[index] as! String
        vc.pageIndex = index
        
        return vc
    }
    
    
    //MARK - DataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
    
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if((index == 0) || index == NSNotFound){
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if(index == NSNotFound){
            return nil
        }
        index++
        if(index == self.pageTitles.count){
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
