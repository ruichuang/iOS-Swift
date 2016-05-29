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
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPage = 0
        
        //using this disable autoresizing
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        return pageControl
    }()
    
    let useAsGuestButton: UIButton! = {
        
        let uag = UIButton(type: .System)
        uag.translatesAutoresizingMaskIntoConstraints = false
        uag.setTitle("Use as guest", forState: .Normal)
        uag.backgroundColor = UIColor(red: 179/255, green: 181/255, blue: 183/255, alpha: 1)
        uag.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        return uag
    }()
    
    let signInButton: UIButton! = {
        
        let uag = UIButton(type: .System)
        uag.translatesAutoresizingMaskIntoConstraints = false
        uag.setTitle("Sign in", forState: .Normal)
        uag.backgroundColor = UIColor(red: 22/255, green: 141/255, blue: 199/255, alpha: 1)
        uag.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        return uag
    }()
    
    let joinButton: UIButton! = {
        
        let jb = UIButton(type: .System)
        jb.translatesAutoresizingMaskIntoConstraints = false
        jb.setTitle("Join now", forState: .Normal)
        jb.titleLabel?.font = UIFont.systemFontOfSize(11)
        jb.backgroundColor = UIColor.clearColor()
        jb.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        
        return jb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set status bar to white in specfic vc
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        self.view.addSubview(useAsGuestButton)
        self.view.addSubview(signInButton)
        self.view.addSubview(pageControl)
        self.view.addSubview(joinButton)
        //add contraints to control, specify on side margin, no need | on the other side, options: using []
        let constraintX = NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: [], metrics: nil, views: ["v0":pageControl])
        let constraintY = NSLayoutConstraint.constraintsWithVisualFormat("V:[v0]-80-|", options: [], metrics: nil, views: ["v0":pageControl])
        NSLayoutConstraint.activateConstraints(constraintX)
        NSLayoutConstraint.activateConstraints(constraintY)
        
        let buttonConstraintX = NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[v0]-10-[v1(==v0)]-80-|", options: [], metrics: nil, views: ["v0":useAsGuestButton, "v1": signInButton])
        let buttonConstraintY1 = NSLayoutConstraint.constraintsWithVisualFormat("V:[v0(35)]-50-|", options: [], metrics: nil, views: ["v0":useAsGuestButton])
        let buttonConstraintY2 = NSLayoutConstraint.constraintsWithVisualFormat("V:[v0(35)]-50-|", options: [], metrics: nil, views: ["v0":signInButton])

        NSLayoutConstraint.activateConstraints(buttonConstraintX)
        NSLayoutConstraint.activateConstraints(buttonConstraintY1)
        NSLayoutConstraint.activateConstraints(buttonConstraintY2)
        
        let joinButtonConstarintX = NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: [], metrics: nil, views: ["v0": joinButton])
        let joinButtonConstraintY = NSLayoutConstraint.constraintsWithVisualFormat("V:[v0]-10-|", options: [], metrics: nil, views: ["v0":joinButton])
        NSLayoutConstraint.activateConstraints(joinButtonConstarintX)
        NSLayoutConstraint.activateConstraints(joinButtonConstraintY)
        
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        for i in 0...3 {
            let iv = UIImageView(frame: CGRectMake(width * CGFloat(i), 0, width, height))
            iv.image = UIImage(named: "ct\(i + 1)")
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
    }


    

}

