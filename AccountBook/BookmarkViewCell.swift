//
//  BookmarkViewCell.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 28..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class BookmarkViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    
    var account: ACCOUNT? {
        didSet {
            nameLabel.text = account!.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //
    }
}
