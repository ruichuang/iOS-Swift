//
//  DetailController.swift
//  appstore1
//
//  Created by Rui on 2016-05-22.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var app: App? {
        didSet {
            //navigationItem.title = app?.name
        }
    }
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.collectionView?.alwaysBounceVertical = true
        //print("set bg")
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        //print("register header")
        self.collectionView?.registerClass(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //print("dequeue")
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerId, forIndexPath: indexPath) as! AppDetailHeader
        header.app = app
        
        return header
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //print("set size")
        return CGSizeMake(view.frame.width, 205)
    }
}


class AppDetailHeader: BaseCell {
    
    var app: App? {
        didSet{
            if let imageName = app?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            
            nameLabel.text = app?.name
            
            if let price = app?.price?.stringValue {
                buyButton.setTitle("$\(price)", forState: .Normal)
            }
        }
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        iv.layer.cornerRadius = 30
        iv.layer.masksToBounds = true
        //print("imageview")
        return iv
    }()
    
    var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.tintColor = UIColor.lightGrayColor()
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "ssss"
        lbl.font = UIFont.systemFontOfSize(18)
        return lbl
    }()
    
    var buyButton: UIButton = {
        let btn = UIButton(type: .System)
        btn.setTitle("GET", forState: .Normal)
        btn.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).CGColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        return btn
    }()
    
    var dividerView: UIView = {
        let dv = UIView()
        dv.backgroundColor = UIColor(white: 0.2, alpha: 0.4)
        return dv
    }()
    
    override func setupViews() {
        
        super.setupViews()
        //print("set bg-blue")
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(dividerView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstranisWithFormat("H:|-14-[v0(140)]-8-[v1]|", views: imageView, nameLabel)
        addConstranisWithFormat("V:|-14-[v0(140)]", views: imageView)
        addConstranisWithFormat("V:|-14-[v0(22)]", views: nameLabel)
        
        addConstranisWithFormat("H:|-50-[v0]-50-|", views: segmentedControl)
        addConstranisWithFormat("V:[v0(34)]-8-|", views: segmentedControl)
        
        addConstranisWithFormat("H:[v0(60)]-14-|", views: buyButton)
        addConstranisWithFormat("V:[v0(32)]-56-|", views: buyButton)
        
        addConstranisWithFormat("H:|[v0]|", views: dividerView)
        addConstranisWithFormat("V:[v0(0.5)]|", views: dividerView)
    }
    
}

extension UIView {
    func addConstranisWithFormat(format: String, views: UIView...){
        var viewsDictory = [String: UIView]()
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            viewsDictory[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictory))
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //print("call setupViews")
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        //print("setup view called")
    }
}
