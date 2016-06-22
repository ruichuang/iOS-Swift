//
//  ViewController.swift
//  YouTube_HomeFeed
//
//  Created by Rui on 2016-06-14.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video] = {
        
        var yourChannel = Channel()
        yourChannel.name = "This is your channel"
        yourChannel.profileImageName = "adele_profile"
        
        var adeleVideo = Video()
        adeleVideo.title = "Adele - 21"
        adeleVideo.thumbnialImageName = "adele_cover"
        adeleVideo.channel = yourChannel
        adeleVideo.numberOfViews = 894573943
        
        var newRomantics = Video()
        newRomantics.title = "Taylor Swift - New Romantics - Taylor Swift - New Romantics"
        newRomantics.thumbnialImageName = "New Romantics"
        newRomantics.channel = yourChannel
        newRomantics.numberOfViews = 876348783
        
        
        return [adeleVideo, newRomantics]

    }() 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.translucent = false
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFontOfSize(20)
        titleLabel.textColor = UIColor.whiteColor()
        navigationItem.titleView = titleLabel
        
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        //push the collection view down
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    //search and more button
    func setupNavBarButtons(){
        let searchImage = UIImage(named: "search_icon")?.imageWithRenderingMode(.AlwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .Plain, target: self, action: #selector(handleSearch))
        
        let moreBtn = UIBarButtonItem(image: UIImage(named: "more_icon")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector (handleMore))
        navigationItem.rightBarButtonItems = [moreBtn ,searchBarButtonItem]
        
    }
    
    func handleMore(){
        
    }
    
    func handleSearch(){
        
        
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
        
    }
        
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.item]
        
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSizeMake(view.frame.width, height + 16 + 88)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}





















