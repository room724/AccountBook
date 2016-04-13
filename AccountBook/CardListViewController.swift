//
//  CardListViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 9..
//  Copyright © 2016년 room724. All rights reserved.
//

import Foundation
import UIKit

class CardListViewController: UITableViewController {
    
    var groupId: NSNumber?
    var cardType: CardType?
    var cards: [Card]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCards()
    }
    
    func fetchCards() {
        let (cards, error) = CORE_DATA_MANAGER.fetchCards(groupId: groupId!, type: cardType!)
        
        if error != nil {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        self.cards = cards
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(CardListViewCell.self), forIndexPath: indexPath) as! CardListViewCell
        let card = cards![indexPath.row]
        
        cell.card = card
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            //
        }
    }
}
