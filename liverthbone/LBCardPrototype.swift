//
//  LBCardPrototype.swift
//  liverthbone
//
//  Created by Sergey Klimov on 4/20/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import Foundation

public class LBCardPrototype : Printable {
    enum LBCardType: String {
        case Minion = "Minion",
        Weapon = "Weapon",
        Spell = "Spell",
        Hero = "Hero",
        Power = "Power"
    }
    
    struct LBHero {
        var name: String
    }
    
    struct LBCardSet {
        var name: String
    }
    
    struct LBCardQuality {
        var name: String
    }
    
    struct LBCardImplementation {
        enum Aura {
            case Shield, Taunt
        }
        /*
        class Filter {
        enum DstPlayer {
        case You, Enemy, Both
        }
        
        enum SrcPlayer {
        case You, Enemy, Both
        }
        enum NamedMinion {
        case Root, Adj, Left, Right
        }
        
        enum Kind : String {
        case AnyCharacter = "AnyCharacter",
        EnemyCharacter = "EnemyCharacter",
        FriendlyCharacter = "FriendlyCharacter",
        AnyMinion = "AnyMinion",
        FriendlyMinion = "FriendlyMinion",
        EnemyMinion = "EnemyMinion",
        AnyWeapon = "AnyWeapon",
        FriendlyWeapon = "FriendlyWeapon",
        EnemyWeapon = "EnemyWeapon",
        AnySecret = "AnySecret",
        EnemySecret = "EnemySecret",
        FriendlySecret = "FriendlySecret"
        }
        
        let kind:Kind?
        let race:String?
        let attackMin:Int?
        let attackMax:Int?
        let healthMin:Int?
        let healthMax:Int?
        let aura:Aura?
        let minionPosition:Int?
        let except:Filter?
        
        init?(json:AnyObject) {
        kind = Kind(rawValue: "EnemyWeapon")
        race = nil
        attackMin = nil
        attackMax = nil
        }
        }
        */
        
        
        
        
        //        let filter:Filter
        
        init?(jsonObject:NSDictionary) {

        }
        
    }
    
    let id:Int
    let name:String
    let type:LBCardType
    let hero:LBHero?
    let cost:Int?
    let desc:String?
    let text:String?
    let artist:String?
    let set:LBCardSet?
    let quality:LBCardQuality?
    let craft:(Int, Int)?
    let disenchant:(Int, Int)?
    
    let impl:LBCardImplementation?
    
    
    //used fo minions and heroes
    let health:Int?
    //used for minions only
    let attack:Int?
    
    public init?(jsonObject:NSDictionary) {
        self.id = jsonObject["id"] as! Int
        self.name = jsonObject["name"] as! String
        self.type = LBCardType(rawValue: jsonObject["type"] as! String)!
        if let heroString = jsonObject["hero"] as? String {
            self.hero = LBHero(name: heroString)
        } else {
            self.hero = nil
        }
        
        
        self.cost = jsonObject["cost"] as? Int ?? nil
        
        self.desc = jsonObject["desc"] as? String ?? nil
        self.text = jsonObject["text"] as? String ?? nil
        self.artist = jsonObject["artist"] as? String ?? nil
        
        
        self.set = jsonObject["set"] as? LBCardSet ?? nil
        self.quality = jsonObject["quality"] as? LBCardQuality ?? nil
        
        self.craft = jsonObject["craft"] as? (Int,Int) ?? nil
        self.disenchant = jsonObject["disenchant"] as? (Int,Int) ?? nil
        
        self.health = jsonObject["health"] as? Int ?? nil
        self.attack = jsonObject["attack"] as? Int ?? nil

        
        if let implObj = jsonObject["impl"] as? NSDictionary {
            self.impl = LBCardImplementation(jsonObject:implObj)
        } else {
            self.impl = nil
        }
        
        //verify type specific parameters
        
        switch self.type {
        case .Minion:
            if (self.health==nil || self.attack == nil || self.cost == nil) {return nil}
        case .Weapon:
            if (self.health==nil || self.attack == nil || self.cost == nil) {return nil}
        case .Spell:
            if (self.cost == nil) {return nil}
        case .Power:
            if (self.cost == nil) {return nil}
        case .Hero:
            if (self.health==nil) {return nil}

        }
    }
    
    public var description : String {
        return "[\(name) \(cost)]"
    }
}
