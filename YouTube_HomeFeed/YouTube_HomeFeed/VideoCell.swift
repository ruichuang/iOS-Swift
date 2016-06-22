//
//  VideoCell.swift
//  YouTube_HomeFeed
//
//  Created by Rui on 2016-06-20.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            if let thumbnailImageName = video?.thumbnialImageName {
                thumbnailImageView.image = UIImage(named: thumbnailImageName)
            }
            
            if let profileImageName = video?.channel?.profileImageName{
                userProfileImageView.image = UIImage(named: profileImageName)
            }
            
            if let channelName = video?.channel?.name, numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = .DecimalStyle
                
                let subTitleText = "\(channelName) • \(numberFormatter.stringFromNumber(numberOfViews)!) views  • 2 years ago "
                subtitleTextView.text = subTitleText
            }
            
            //determine title size
            if let title = video?.title {
                let size = CGSizeMake(frame.width - 16 - 44 - 8 - 16, 1000)
                let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelheightConstraint?.constant = 44
                } else {
                    titleLabelheightConstraint?.constant = 20
                }
            }
            
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "adele_cover")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = UIColor.greenColor()
        imageView.image = UIImage(named: "adele_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
        
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adele - 21"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = UIColor.redColor()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "AdeleLaurieBlueAdkinsVEVO • 1,345,847,940 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGrayColor()
        return textView
    }()
    
    var titleLabelheightConstraint: NSLayoutConstraint?
    
    override func setupViews(){
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView ,separatorView)
        addConstraintsWithFormat("H:|[v0]|", views: separatorView)
        
        //top
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Bottom, multiplier: 1, constant: 8))
        //left
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //right
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        //height
        titleLabelheightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 44)
        addConstraint(titleLabelheightConstraint!)
        
        //***********************************************************************************
        
        //top
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
        //left
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //right
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        //height
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
        
    }
}

