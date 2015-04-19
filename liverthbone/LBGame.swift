//
//  LBGame.swift
//  liverthbone
//
//  Created by Sergey Klimov on 4/18/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import UIKit


struct LBMana: Printable {
    var used = 0
    var locked = 0
    var borrowed = 0
    var base = 0
    
    func available()->Int {
        return base+borrowed - used - locked
    }
    
    var description: String {
        return "\(used)/\(base+borrowed-locked)"
    }
}

class LBGamePlayer: NSObject {
    var player:LBPlayer
    var klass:LBClass
    var deck:LBDeck
    var hand = [LBCard]()
    var life = 30
    
    var mana = LBMana(used: 0, locked: 0, borrowed: 0, base: 0)
    
    var turnCount = 0
    
    init(player:LBPlayer, klass:LBClass, deck:LBDeck) {
        self.player = player
        self.klass = klass
        self.deck = deck
    }
    
    func drawCard()->LBCard {
        var card = deck.takeCard()
        
        hand.append(card)
        return card
        
    }
    
    
}

protocol LBGameDelegate {
    func gameMulliganExpected(game:LBGame, player:LBGamePlayer, cards:[LBCard])
    func gameMulliganResult(game:LBGame, player:LBGamePlayer, cards:[LBCard])

    func gameCardPlayed(game:LBGame, player:LBGamePlayer, card:LBCard)
    func gameCardDrawn(game:LBGame, player:LBGamePlayer, card:LBCard)
    func gameManaChanged(game:LBGame, player:LBGamePlayer, manaChange:LBMana)
    func gameExpectsTurn(game:LBGame, player:LBGamePlayer)
}

class LBGame: NSObject {
    var players: [LBGamePlayer]
    var currentPlayer:LBGamePlayer
    var delegate: LBGameDelegate?
    
    init(players:[(player:LBPlayer,klass:LBClass,deck:LBDeck)]) {
        self.players = players.map({playerTuple in let (player, klass, deck) = playerTuple; return LBGamePlayer(player: player, klass: klass, deck: deck);})
        
        // determine first player
        //todo random
        currentPlayer = self.players[0]

        
        
    }

    func startTurn() {
//        if currentPlayer.turnCount == 0 {
//            var cards = currentPlayer.deck.takeCards(count: 4)
//            self.delegate?.gameMulliganExpected(self, player: currentPlayer, cards: cards)
//        }
        currentPlayer.turnCount += 1
        
        var manaChange = LBMana(used: 0, locked: 0, borrowed: 0, base: 0)
        if (currentPlayer.mana.base < 10) {
            currentPlayer.mana.base++
            manaChange.base = 1
        }
        
        if (currentPlayer.mana.locked > 0) {
            manaChange.locked = -currentPlayer.mana.locked
            currentPlayer.mana.locked = 0
        }
        if (currentPlayer.mana.borrowed > 0) {
            manaChange.borrowed = -currentPlayer.mana.borrowed
            currentPlayer.mana.borrowed = 0
        }
        
        if (currentPlayer.mana.used > 0) {
            manaChange.used = -currentPlayer.mana.used
            currentPlayer.mana.used = 0
        }
        
        
        self.delegate?.gameManaChanged(self, player: currentPlayer, manaChange: manaChange)
        
        var card = currentPlayer.drawCard()
        
        self.delegate?.gameCardDrawn(self, player: currentPlayer, card: card)
        
        self.delegate?.gameExpectsTurn(self, player: currentPlayer)
        
    }

    
    func nextPlayer() {
        var playerIndex:Int = find(players, currentPlayer)!
        playerIndex += 1
        if (playerIndex >= players.count) {
            playerIndex = 0
        }
        currentPlayer = players[playerIndex]
    }
    
// public apis
    func chooseMulligan(player:LBGamePlayer, cards:[LBCard]) {
        
    }
    
    
    func finishTurn() {
        nextPlayer()
        startTurn()
    }
    
    func startGame() {
        
        for player in self.players {
            player.deck.shuffle()
        }
        
        startTurn()
    }
    
}
