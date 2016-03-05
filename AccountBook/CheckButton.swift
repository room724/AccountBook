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
        nibName = "CheckButton"
    }
    
    override func sizeToFit() {
        if let nib = nib {
            
            nib.sizeToFit()
            nib.width += nib.titleEdgeInsets.left + nib.titleEdgeInsets.right
            
            // todo
        }
    }
    
    @IBInspectable var title: String? {
        didSet {
            updateTitle()
        }
    }
    
    @IBInspectable var checked: Bool = false {
        didSet {
            updateChecked()
        }
    }
    
    @IBInspectable var nibName: String? {
        didSet {
            nib?.removeFromSuperview()
            nib = NSBundle(forClass: classForCoder).loadNibNamed(nibName, owner: self, options: nil).first as? UIButton
            nib?.frame = bounds
            addSubview(nib!)
            
            updateTitle()
            updateChecked()
        }
    }
    
    private func updateTitle() {
        nib?.setTitle(title, forState: .Normal)
        
        sizeToFit()
    }
    
    private func updateChecked() {
        nib?.selected = checked
    }
}
