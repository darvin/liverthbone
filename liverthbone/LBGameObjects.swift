//
//  LBGameObjects.swift
//  liverthbone
//
//  Created by Sergey Klimov on 4/22/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//



public class LBBindable {
    public typealias BindFunction = ([AnyObject])->(Void)
    public typealias BindHandlerReference = Int

    typealias BindHandler = (function:BindFunction, once:Bool, reference:BindHandlerReference)
    
    private static var lastReference:BindHandlerReference = 0
    
    
    var events :[String:[BindHandler]]
    
    
    public init() {
        self.events = Dictionary()
    }
    
    
    public func bind(event:String, function:BindFunction, once:Bool=false) ->BindHandlerReference {
        let reference = LBBindable.lastReference++
        if events[event] == nil {
            events[event] = []
        }
        events[event]? += [(function:function, once:once, reference:reference)]
        return reference
    }
    
    
    public func trigger(event:String, args:[AnyObject]) {
        if let handlers = events[event] {
            events[event] = handlers.filter {
                $0.function(args)
                return !$0.once
            }

        }
        
    }
    public func unbind(event:String, handlerReference:BindHandlerReference) {
        if let handlers = events[event] {
            events[event] = handlers.filter {$0.reference != handlerReference}
        }
    }

    
}


class LBPlayer {
    
}

class LBGameObject {
    var effects = []
    var auras = []
    var buffs = []
    var player:LBPlayer? = nil
    
    init(effects,)
    
}
