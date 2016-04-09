//
//  AccountListViewCell.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 12..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountListViewCell : UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    var transaction: Transaction? {
        didSet {
            //dateLabel.text = transaction!.date!
            titleLabel.text = transaction!.name
            //moneyLabel.text = transaction!.money
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //
    }
}
