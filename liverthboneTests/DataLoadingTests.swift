//
//  DataLoadingTests.swift
//  liverthbone
//
//  Created by Sergey Klimov on 4/20/15.
//  Copyright (c) 2015 Sergey Klimov. All rights reserved.
//

import UIKit
import XCTest
import liverthbone

//expects CardData.json from https://dl.dropboxusercontent.com/u/2989349/focus_data/CardData.json

var cardDataJsonPath = "./CardData.json"



class DataLoadingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAllCardsImplsAreWorking() {
        let cardsData: NSArray
        if let path = NSBundle(forClass: self.dynamicType).pathForResource("CardData", ofType: "json") {
            let data = NSData(contentsOfFile:path)
            var parseError: NSError?
            let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions.AllowFragments,
                error:&parseError)
            XCTAssertNil(parseError, "shold be parsed")
            cardsData = parsedObject as! NSArray
            
            for cardData in cardsData as! [NSDictionary] {
                var card:liverthbone.LBCardPrototype = liverthbone.LBCardPrototype(jsonObject: cardData)!
                println("Card \(card) loaded")
            }
        }
        
 
        
        
        XCTAssert(true, "Pass")
    }



}
