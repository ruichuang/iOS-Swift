//
//  ViewController.swift
//  Linkedin
//
//  Created by Rui on 2016-05-27.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!

    // setting position using constraints, no need frame:CGMake()
    let pageControl: UIPageControl =  {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.pageIndicatorTintColor = UIColor.darkGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPage = 0
        
        //using this disable autoresizing
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        return pageControl
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pageControl)
        //add contraints to control, specify on side margin, no need | on the other side, options: using []
        let constraintX = NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: [], metrics: nil, views: ["v0":pageControl])
        let constraintY = NSLayoutConstraint.constraintsWithVisualFormat("V:[v0]-40-|", options: [], metrics: nil, views: ["v0":pageControl])
        NSLayoutConstraint.activateConstraints(constraintX)
        NSLayoutConstraint.activateConstraints(constraintY)
        
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        for i in 0...3 {
            let iv = UIImageView(frame: CGRectMake(width * CGFloat(i), 0, width, height))
            iv.image = UIImage(named: "ny\(i + 1)")
            iv.contentMode = .ScaleAspectFill
            iv.clipsToBounds = true
            iv.userInteractionEnabled = true
            self.scrollView.addSubview(iv)
            
        }
        self.scrollView.contentSize = CGSize(width: width * 4, height: height)
        pageControl.addTarget(self, action:
            #selector(ViewController.pageChange(_:)), forControlEvents:
        UIControlEvents.ValueChanged)
    }
    
    func pageChange(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }


    

}

