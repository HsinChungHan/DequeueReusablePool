//
//  DoublyLinkedListTest.swift
//  TableViewReusableImplementationTests
//
//  Created by Chung Han Hsin on 2021/1/13.
//

import XCTest
@testable import TableViewReusableImplementation

class DoublyLinkedListTest: XCTestCase {

    var linkedList: DoublyLinkedList<Int>!
    
    override func setUpWithError() throws {
        linkedList = DoublyLinkedList<Int>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPush() {
        linkedList.push(value: 1)
        linkedList.push(value: 2)
        linkedList.push(value: 3)
        linkedList.push(value: 4)
        let result = DoublyLinkedList.traverse(head: linkedList.head)
        XCTAssert(result == [4,3,2,1])
    }

    func testPop() {
        linkedList.push(value: 1)
        linkedList.push(value: 2)
        linkedList.push(value: 3)
        linkedList.push(value: 4)
        linkedList.popNode()
        let result = DoublyLinkedList.traverse(head: linkedList.head)
        XCTAssert(result == [4,3,2])
    }
    
    func testPushAll() {
        let values = [1,2,3,4]
        linkedList.push(values: values)
        let result = DoublyLinkedList.traverse(head: linkedList.head)
        XCTAssert(result == [4,3,2,1])
    }
    
    func testPopAll() {
        let values = [1,2,3,4]
        linkedList.push(values: values)
        linkedList.popAll()
        let result = DoublyLinkedList.traverse(head: linkedList.head)
        XCTAssert(result == [])
    }
    
    func testPopAllThenPush() {
        let values = [1,2,3,4]
        linkedList.push(values: values)
        linkedList.popAll()
        linkedList.push(value: 1)
        linkedList.push(value: 2)
        let result = DoublyLinkedList.traverse(head: linkedList.head)
        XCTAssert(result == [2, 1])
    }
    
}
