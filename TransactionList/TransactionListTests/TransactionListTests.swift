//
//  TransactionListTests.swift
//  TransactionListTests
//
//  Created by FAURE-VIDAL Laurene  on 27/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import XCTest
@testable import TransactionList

class TransactionListTests: XCTestCase {
    var dm: DataManager!
    override func setUp() {
        super.setUp()
      dm = DataManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetTransaction() {
        dm.getTransactions()
        sleep(5)
        XCTAssertTrue(dm.transactionList.count > 0)
    }
  
}
