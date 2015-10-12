//
//  GameObjectsTests.swift
//  liverthbone
//
//  Created by Sergey Klimov on 4/22/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import UIKit
import XCTest
import liverthbone

class GameObjectsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBindable() {
        var accum = 0
        class TestEventTarget: liverthbone.LBBindable {
            
        }
        
        
        var bindedFunc = { (args:[AnyObject]) -> (Void) in
            accum += args[0] as! Int
        }
        var target = TestEventTarget()
        let firstRef = target.bind("add_number", function: bindedFunc)
        
        target.trigger("add_number", args: [1])
        target.trigger("add_number", args: [1])
        XCTAssertEqual(accum, 2, "Should trigger properly")
        target.trigger("non_existing", args: [1])
        XCTAssertEqual(accum, 2, "Should trigger properly")
        target.trigger("add_number", args: [1])
        XCTAssertEqual(accum, 3, "Should trigger properly")
        target.unbind("add_number", handlerReference: firstRef)
        target.trigger("add_number", args: [1])
        XCTAssertEqual(accum, 3, "Should trigger properly")

        target.bind("add_number", function: bindedFunc, once:true)
        target.trigger("add_number", args: [1])
        XCTAssertEqual(accum, 4, "Should trigger properly")
        target.trigger("add_number", args: [1])
        XCTAssertEqual(accum, 4, "Should trigger properly")

        
    }



}
