//
//  GroupViewCell.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

protocol GroupViewCellDelegate {
    
    func favoriteButtonTappedInGroupViewCell(groupViewCell: GroupViewCell)
}

class GroupViewCell: UITableViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    
    var delegate: GroupViewCellDelegate?

    var account: ACCOUNT? {
        didSet {
            favoriteButton.selected = account!.favorite?.boolValue ?? false
            nameLabel.text = account!.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        favoriteButton.setTitle("-", forState: .Normal)
        favoriteButton.setTitle("@", forState: .Selected)
    }

    @IBAction func favoriteButtonTapped(sender: AnyObject) {
        delegate?.favoriteButtonTappedInGroupViewCell(self)
    }
}
