//
//  CategoryListViewCell.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 9..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class CategoryListViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var category: Category? {
        didSet {
            nameLabel.text = category!.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //
    }
}
