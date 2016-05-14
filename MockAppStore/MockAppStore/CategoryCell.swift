//
//  CategoryCell.swift
//  MockAppStore
//
//  Created by Rui on 2016-05-10.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var appCategory: AppCategory? {
        didSet {
            if let name = appCategory?.name {
                nameLabel.text = name
            }
        }
    }
    private let cellId = "appCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "New Games We Love"
        lbl.font = UIFont.systemFontOfSize(16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let appsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews () {
        // add lbls, btns here
        backgroundColor = UIColor.clearColor()
        
        addSubview(appsCollectionView)
        addSubview(dividerView)
        addSubview(nameLabel)
        
        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
        
        //register
        
        appsCollectionView.registerClass(AppCell.self, forCellWithReuseIdentifier: cellId)
        
        // MARK: constraints
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : dividerView]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : appsCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[nameLabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : appsCollectionView, "v1": dividerView, "nameLabel": nameLabel]))
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.apps?.count{
            return count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(100, frame.height - 32)
    }
    
    func collectionView(_collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,                         insetForSectionAtIndex section: Int) -> UIEdgeInsets{

        return UIEdgeInsetsMake(0, 12, 0, 12)
    }
   
}

class AppCell: UICollectionViewCell{
    
    var app: App? {
        didSet {
            if let name = app?.name {
                nameLabel.text = name
                
                let rect = NSString(string: name).boundingRectWithSize(CGSizeMake(frame.width, 1000), options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
                
                if rect.height > 20 {
                    categoryLabel.frame = CGRectMake(0, frame.width + 38, frame.width, 20)
                    priceLabel.frame = CGRectMake(0, frame.width + 56, frame.width, 20)
                } else {
                    categoryLabel.frame = CGRectMake(0, frame.width + 22, frame.width, 20)
                    priceLabel.frame = CGRectMake(0, frame.width + 40, frame.width, 20)
                }
                
                nameLabel.frame = CGRectMake(0, frame.width + 5, frame.width, 40)
                nameLabel.sizeToFit()
            }
            
            categoryLabel.text = app?.category
            if let price = app?.price {
                priceLabel.text = "$\(price)"
            } else {
                priceLabel.text = ""
            }
            
            if let imageName = app?.imageName {
                imageView.image = UIImage(named: imageName)
                //print(imageName)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Clash of Clans"
        lbl.font = UIFont.systemFontOfSize(14)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Game"
        lbl.font = UIFont.systemFontOfSize(13)
        lbl.textColor = UIColor.darkGrayColor()
        return lbl
    }()

    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "$ 5.99"
        lbl.font = UIFont.systemFontOfSize(13)
        lbl.textColor = UIColor.darkGrayColor()
        return lbl
    }()
    
    
    
    func setupView() {
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        
        // width=height=frame.width
        imageView.frame = CGRectMake(0, 0, frame.width, frame.width)
        nameLabel.frame = CGRectMake(0, frame.width + 2, frame.width, 40)
        categoryLabel.frame = CGRectMake(0, frame.width + 38, frame.width, 20)
        priceLabel.frame = CGRectMake(0, frame.width + 56, frame.width, 20)
    }
}




















