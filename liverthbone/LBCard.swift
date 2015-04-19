//
//  LBCard.swift
//  liverthbone
//
//  Created by Sergey Klimov on 4/18/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import UIKit

class LBCard: NSObject {
    var cost:Int
    var text:String
    var flavorText:String
    var name:String
   
    init(cost:Int, text:String, flavorText:String, name:String) {
        self.cost = cost
        self.text = text
        self.flavorText = flavorText
        self.name = name
    }
}
