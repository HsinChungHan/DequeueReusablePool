//
//  ViewReusablePoolTest.swift
//  TableViewReusableImplementationTests
//
//  Created by Chung Han Hsin on 2021/1/13.
//

import XCTest
@testable import TableViewReusableImplementation

class ViewReusablePoolTest: XCTestCase {

    var viewReuseablePool: ViewReuseablePool!
    override func setUpWithError() throws {
        viewReuseablePool = ViewReuseablePool()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMultipleCellWithSameIdByAddInUsingView() {
        let idA = "cellA"
        let idB = "cellB"
        let cellA1 = UITableViewCell(style: .default, reuseIdentifier: idA)
        let cellB1 = UITableViewCell(style: .default, reuseIdentifier: idB)
        viewReuseablePool.addUsingView(id: idA, view: cellA1)
        viewReuseablePool.addUsingView(id: idB, view: cellB1)
        let usingQueueTraverseResult = viewReuseablePool.traverseQueues(ids: idA, idB, type: .Using)
        let waitingQueueTraverseResult = viewReuseablePool.traverseQueues(ids: idA, idB, type: .Using)
        XCTAssert(usingQueueTraverseResult == [idA, idB])
        XCTAssert(waitingQueueTraverseResult == [idA, idB])
    }
}
