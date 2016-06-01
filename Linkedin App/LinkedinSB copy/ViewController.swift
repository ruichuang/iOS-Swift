//
//  ViewController.swift
//  LinkedinSB
//
//  Created by Rui on 2016-05-30.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.logoImage.center.y += self.view.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        scrollView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let width = self.scrollView.frame.width
        let height = self.scrollView.frame.height
        
        for i in 0...3 {
            let iv = UIImageView(frame: CGRectMake(width * CGFloat(i), 0, width, height))
            iv.image = UIImage(named: "ct\(i+1)")
            iv.contentMode = .ScaleAspectFill
            iv.clipsToBounds = true
            iv.userInteractionEnabled = true
            self.scrollView.addSubview(iv)
            
            
        }
        self.scrollView.contentSize = CGSizeMake(width * 4, height)
        
        
                
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let currentPage = scrollView.contentOffset.x / UIScreen.mainScreen().bounds.width + 0.5
            self.pageControl.currentPage = Int(currentPage)
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait

    }
    //set status bar color
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
    }

}

