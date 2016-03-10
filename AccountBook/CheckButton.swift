//
//  CheckButton.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 5..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

@IBDesignable class CheckButton : UIView {
    
    private var nib: UIButton?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        updateNib()
        
        self.performSelector("invalidateIntrinsicContentSize", withObject: nil, afterDelay: 3)
    }
    
    /*
    override func alignmentRectForFrame(frame: CGRect) -> CGRect {
        return CGRect(x: frame.origin.x, y: frame.origin.y, width: 100, height: 24)
    }
    
    override func frameForAlignmentRect(alignmentRect: CGRect) -> CGRect {
        return CGRect(x: alignmentRect.origin.x, y: alignmentRect.origin.y, width: 100, height: 24)
    }
    */
    
    override func intrinsicContentSize() -> CGSize {
        if let nib = nib {
            return nib.size
        }
        
        return size
    }
    
    @IBInspectable var nibName: String = "CheckButton" {
        didSet {
            updateNib()
        }
    }
    
    @IBInspectable var title: String = "" {
        didSet {
            updateTitle()
        }
    }
    
    @IBInspectable var checked: Bool = false {
        didSet {
            updateChecked()
        }
    }
    
    private func updateNib() {
        nib?.removeFromSuperview()
        nib = NSBundle(forClass: classForCoder).loadNibNamed(nibName, owner: self, options: nil).first as? UIButton
        addSubview(nib!)
        
        updateTitle()
        updateChecked()
    }
    
    private func updateTitle() {
        if let nib = nib {
            nib.setTitle(title, forState: .Normal)
            nib.sizeToFit()
            nib.width += nib.titleEdgeInsets.left + nib.titleEdgeInsets.right
            
            invalidateIntrinsicContentSize()
        }
    }
    
    private func updateChecked() {
        nib?.selected = checked
    }
}
