//
//  CardListViewCell.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 10..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class CardListViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var card: Card? {
        didSet {
            nameLabel.text = card!.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //
    }
}
