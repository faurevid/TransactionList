//
//  TransactionListTests.swift
//  TransactionListTests
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 27/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import XCTest
@testable import TransactionList

class TransactionListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let dm = DataManager()
        dm.getTransactions()
        sleep(5)
        XCTAssertTrue(dm.transactionList.count > 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
