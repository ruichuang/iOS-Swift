//
//  ScreenshotCell.swift
//  appstore1
//
//  Created by Rui on 2016-05-23.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class ScreenshotsCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var app: App? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clearColor()
        
        return cv
    }()
    
    private let cellId = "cellId"
    
    let dividerView: UIView = {
        let dv = UIView()
        dv.backgroundColor = UIColor(white: 0.2, alpha: 0.4)
        return dv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(dividerView)
        addSubview(collectionView)
        
        addConstranisWithFormat("H:|[v0]|", views: collectionView)
        addConstranisWithFormat("H:|-14-[v0]|", views: dividerView)
        addConstranisWithFormat("V:|[v0][v1(1)]|", views: collectionView, dividerView)
        
        
        collectionView.registerClass(ScreenshotImageCell.self , forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = app?.screenshots?.count {
            return count
        }
        
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId , forIndexPath: indexPath) as! ScreenshotImageCell
        
        if let imageName = app?.screenshots?[indexPath.item] {
            cell.imageView.image = UIImage(named: imageName)

        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(260, frame.height - 20)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
    private class ScreenshotImageCell: BaseCell {
        
        let imageView: UIImageView = {
           let iv = UIImageView()
            iv.contentMode = .ScaleAspectFill
            iv.backgroundColor = UIColor.lightGrayColor()
            return iv
        }()
        
        private override func setupViews() {
            super.setupViews()
            
            layer.masksToBounds = true
            
            addSubview(imageView)
            addConstranisWithFormat("H:|[v0]|", views: imageView)
            addConstranisWithFormat("V:|[v0]|", views: imageView)
            
        }
    }
}