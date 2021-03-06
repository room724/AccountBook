//
//  GroupListViewCell.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class GroupListViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var equityLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    
    var group: Group? {
        didSet {
            nameLabel.text = group!.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //
    }
}
