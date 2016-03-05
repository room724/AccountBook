//
//  UIView+Layout.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

extension UIView {
    
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var newFrame = frame
            newFrame.origin.x = newValue
            frame = newFrame
        }
    }
    
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var newFrame = frame
            newFrame.origin.y = newValue
            frame = newFrame
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var newFrame = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
    }
    
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var newFrame = frame
            newFrame.size.height = newValue
            frame = newFrame
        }
    }
    
    public var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            var newFrame = frame
            newFrame.origin = newValue
            frame = newFrame
        }
    }
    
    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            var newFrame = frame
            newFrame.size = newValue
            frame = newFrame
        }
    }
    
}
