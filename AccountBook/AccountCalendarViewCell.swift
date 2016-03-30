//
//  AccountCalendarViewCell.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 12..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountCalendarViewCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    var transaction: TRANSACTION? {
        didSet {
            //dateLabel.text = transaction!.date!
            titleLabel.text = transaction!.name
            //moneyLabel.text = transaction!.money
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
