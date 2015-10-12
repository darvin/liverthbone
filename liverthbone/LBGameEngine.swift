//
//  LBGameEngine.swift
//  liverthbone
//
//  Created by Sergey Klimov on 4/22/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import Foundation

class LBCardsBase {
    func prototype(name:String)->LBCardPrototype {
        return LBCardPrototype(jsonObject: NSDictionary())! //fixme
    }
}

class LBCard {
    let name:String
    
    private var prototype : LBCardPrototype?
    
    
    init(name:String) {
        self.name = name
        self.prototype = nil
    }
    
    func loadPrototype(cardBase:LBCardsBase) -> LBCardPrototype {
        if prototype == nil {
            prototype = cardBase.prototype(name)
        }
        return prototype!
    }
}


class LBDeck {
    var cards:[LBCard]
    let hero:LBCard
    init?(cards:[LBCard], hero:LBCard) {
        self.cards = cards
        self.hero = hero

        if cards.count != 30 {
            return nil
        }
    }
    
    func shuffle() {
        
    }
    
    func drawCard() -> LBCard {
        var card = cards.last!
        cards.removeLast()
        return card
    }
    
    func canDraw() -> Bool {
        return cards.count>0
    }
    
    func putBack(card:LBCard) {
        cards += [card]
        shuffle()
    }
}


class LBPlayerAgent {
    
}

class LBGameEngine {
    
    
    init(decks:[LBDeck], agents:[LBPlayerAgent], cardBase:LBCardsBase) {
        
    }
   
}
