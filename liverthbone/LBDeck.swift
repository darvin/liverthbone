//
//  LBDeck.swift
//  liverthbone
//
//  Created by Sergey Klimov on 4/18/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import UIKit

class LBDeck: NSObject {
    var name = "Custom Deck"
    var cards = [LBCard]()
    func shuffle() {
        
    }
    
    init(cards: [LBCard], name:String) {
        assert(cards.count==30, "Any deck should have 30 cards")
        self.cards = cards
        self.name = name
    }
    
    func count()->Int {
        return cards.count
    }
    

 
    func takeCards(count:Int = 1) -> [LBCard] {
        var result = [LBCard]()
        for _ in 0...count {
            var card:LBCard = cards.last!
            result.append(card)
            cards.removeLast()
        }
        
        return result
    }
    
    func takeCard() -> LBCard {
        var card = cards.last!
        cards.removeLast()
        return card
    }
    
    func discardCards(cards:[LBCard]) {
        self.cards += cards
        shuffle()
    }
}
