//
//  GroupViewCell.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

protocol GroupViewCellDelegate {
    
    func bookmarkButtonTappedInGroupViewCell(groupViewCell: GroupViewCell)
}

class GroupViewCell: UITableViewCell {

    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    
    var delegate: GroupViewCellDelegate?

    var account: ACCOUNT? {
        didSet {
            bookmarkButton.selected = account!.bookmark?.boolValue ?? false
            nameLabel.text = account!.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookmarkButton.setTitle("-", forState: .Normal)
        bookmarkButton.setTitle("@", forState: .Selected)
    }

    @IBAction func bookmarkButtonTapped(sender: AnyObject) {
        delegate?.bookmarkButtonTappedInGroupViewCell(self)
    }
}
