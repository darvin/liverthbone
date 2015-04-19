//
//  GameScene.swift
//  liverthbone
//
//  Created by Sergey Klimov on 4/18/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import SpriteKit
func getRandomColor() -> UIColor{
    
    var randomRed:CGFloat = CGFloat(drand48())
    
    var randomGreen:CGFloat = CGFloat(drand48())
    
    var randomBlue:CGFloat = CGFloat(drand48())
    
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    
}

class LBButton: SKSpriteNode {
    var onTouchUp: () -> Void = {}
    var onTouchDown: () -> Void = {}
    init(text:String) {
        let textLabel = SKLabelNode(fontNamed:"AppleSDGothicNeo-Bold")
        textLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        textLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Bottom
        textLabel.text = text
        super.init(texture:nil, color:nil, size:textLabel.frame.size)
        self.addChild(textLabel)
        userInteractionEnabled = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
//    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
//        var touch: UITouch = touches.allObjects[0] as! UITouch
//        var location: CGPoint = touch.locationInNode(self)
//        
//        if self.containsPoint(location) {
//            onTouchDown()
//        } else {
//            onTouchUp()
//        }
//    }
//
//    
//    override func touchesEnded(touches: NSSet, event: UIEvent) {
//        var touch: UITouch = touches.allObjects[0] as! UITouch
//        var location: CGPoint = touch.locationInNode(self)
//        
//        if self.containsPoint(location) {
//            onTap()
//        }
//        
//    }

}


class LBPlayerBoardNode: SKSpriteNode {
    weak var player: LBGamePlayer?
    
    var playerName : SKLabelNode
    var deckCount : SKLabelNode
    var playerLives : SKLabelNode
    var playerMana : SKLabelNode
    var itsYourTurn : SKLabelNode
    var showCardsButton: LBButton
    var endTurnButton: LBButton
    
    
    init(player:LBGamePlayer, size:CGSize) {
        playerName = SKLabelNode(fontNamed:"AppleSDGothicNeo-Bold")
        deckCount = SKLabelNode(fontNamed:"AppleSDGothicNeo-Bold")
        playerLives = SKLabelNode(fontNamed:"AppleSDGothicNeo-Bold")
        playerMana = SKLabelNode(fontNamed:"AppleSDGothicNeo-Bold")
        itsYourTurn = SKLabelNode(fontNamed:"AppleSDGothicNeo-Bold")

        showCardsButton = LBButton(text: "Show Cards")
        
        endTurnButton = LBButton(text: "End Turn")
        
        super.init(texture: nil, color:getRandomColor(), size: size)
        self.player = player
        self.name = "playerboard"

        
        showCardsButton.onTouchUp = {self.hideCards() };
        showCardsButton.onTouchDown = {self.showCards() };

        showCardsButton.anchorPoint = CGPoint(x: 0, y: 0)
        showCardsButton.position = CGPoint(x: 10, y: 10)
        
        endTurnButton.anchorPoint = CGPoint(x: 0, y: 0)
        endTurnButton.position = CGPoint(x: self.frame.size.width-endTurnButton.frame.width-10, y: 10)

        itsYourTurn.position = CGPoint(x: self.frame.size.width/2,y: self.frame.height/2)
        itsYourTurn.text = "It's Your Turn!"
        itsYourTurn.fontSize = 83
        itsYourTurn.alpha = 0
        
        playerName.position = CGPoint(x: self.frame.size.width/2,y: 10)
        playerName.fontSize = 34;
        
        deckCount.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        deckCount.position = CGPoint(x:self.frame.size.width-10, y:40)
        playerLives.position = CGPoint(x: self.frame.size.width/2-46,y: 40)
        playerMana.position = CGPoint(x: self.frame.size.width/2+90,y: 20)
        
        
        self.addChild(playerName)
        self.addChild(deckCount)
        self.addChild(playerLives)
        self.addChild(playerMana)
        self.addChild(itsYourTurn)
        self.addChild(showCardsButton)
        self.addChild(endTurnButton)
        
        refreshLabels()
    }
    
    func showCards() {
        println("show cards")
    }
    
    func hideCards() {
        println("hide cards")

    }
    
    func refreshLabels() {
        playerName.text = self.player!.player.name
        deckCount.text = "deck: \(self.player!.deck.count())"
        playerLives.text = "\(self.player!.life)"
        playerMana.text = "\(self.player!.mana)"
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flashItsYourTurn() {
        itsYourTurn.runAction(SKAction.sequence([SKAction.fadeInWithDuration(0.3), SKAction.waitForDuration(0.9), SKAction.fadeOutWithDuration(0.4)]))
    }
    
}


class GameScene: SKScene, LBGameDelegate {
    var gameBoards = [LBGamePlayer:LBPlayerBoardNode]()
    override func didMoveToView(view: SKView) {

        
        startGame(createTestGame())
        
    }
    
    func createTestDeck() -> LBDeck {
        var cards = [LBCard]()
        for i in 1...30 {
            let card = LBCard(cost: Int(arc4random_uniform(7)), text: "Some text", flavorText: "some flavor text", name: "Card name")
            cards.append(card)
        }
        return LBDeck(cards: cards, name:"Test Deck")
        
    }
    
    func createTestGame() -> LBGame {
        
        
        
        let playerTuple1 = (LBPlayer(name: "Player 1"), LBClass(), createTestDeck())
        let playerTuple2 = (LBPlayer(name: "Player 2"), LBClass(), createTestDeck())
        
        
        var game = LBGame(players: [playerTuple1, playerTuple2])
        return game
    }
    
    
    func startGame(game: LBGame) {
        var playerboard1 = LBPlayerBoardNode(player: game.players[0], size:CGSize(width: self.frame.width, height: self.frame.height/2))
        var playerboard2 = LBPlayerBoardNode(player: game.players[1], size:CGSize(width: self.frame.width, height: self.frame.height/2))
        
        gameBoards[game.players[0]] = playerboard1
        gameBoards[game.players[1]] = playerboard2
        
        
        playerboard1.position = CGPoint(x: 0,y: 0)
        playerboard1.anchorPoint = CGPoint(x: 0, y:0)
        playerboard2.position = CGPoint(x: self.frame.size.width,y:self.frame.size.height)
        playerboard2.anchorPoint = CGPoint(x: 0, y:0)
        playerboard2.zRotation = CGFloat(M_PI);

        self.addChild(playerboard1)
        self.addChild(playerboard2)
        
        game.delegate = self
        game.startTurn()
    }
    
    
    
    
    func gameMulliganExpected(game:LBGame, player:LBGamePlayer, cards:[LBCard]) {}
    func gameMulliganResult(game:LBGame, player:LBGamePlayer, cards:[LBCard]) {}
    
    func gameCardPlayed(game:LBGame, player:LBGamePlayer, card:LBCard) {}
    func gameCardDrawn(game:LBGame, player:LBGamePlayer, card:LBCard) {}
    func gameManaChanged(game:LBGame, player:LBGamePlayer, manaChange:LBMana) {}
    func gameExpectsTurn(game:LBGame, player:LBGamePlayer) {
    
        gameBoards[player]!.flashItsYourTurn()

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        /* Called when a touch begins */
//        
//        for touch in (touches as! Set<UITouch>) {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
