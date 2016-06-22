//
//  Video.swift
//  YouTube_HomeFeed
//
//  Created by Rui on 2016-06-21.
//  Copyright © 2016 Rui. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnialImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
    
    
    
}
