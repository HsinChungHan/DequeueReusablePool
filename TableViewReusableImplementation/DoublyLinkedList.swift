//
//  DoublyLinkedList.swift
//  TableViewReusableImplementation
//
//  Created by Chung Han Hsin on 2021/1/12.
//

import Foundation
class Node<T> {
    let value: T
    var preNode: Node<T>?
    var nextNode: Node<T>?
    init(value: T, preNode: Node<T>? = nil, nextNode: Node<T>? = nil) {
        self.value = value
        self.preNode = preNode
        self.nextNode = nextNode
    }
}

class DoublyLinkedList<T> {
    var head: Node<T>? = nil
    var tail: Node<T>? = nil
    
    func push(value: T) {
        let newNode = Node(value: value)
        guard let _ = head else {
            head = newNode
            tail = newNode
            return
        }
        let tmp_node = head
        head = newNode
        head!.nextNode = tmp_node
        tmp_node!.preNode = head
    }
    
    func push(values: [T]) {
        for value in values {
            push(value: value)
        }
    }
    
    @discardableResult
    func popNode() -> T? {
        guard let _ = tail else {
            print("The linked list is empty!")
            return nil
        }
        let popedNode = tail
        tail = tail!.preNode
        tail?.nextNode = nil
        if tail == nil {
            head = nil
        }
        return popedNode?.value
    }
    
    @discardableResult
    func popAll() -> [T]? {
        if isEmpty() {
            return nil
        }
        var popedNodes = [T]()
        var popedNode = popNode()
        while popedNode != nil {
            popedNodes.append(popedNode!)
            popedNode = popNode()
        }
        return popedNodes
    }
    
    func isEmpty() -> Bool {
        return head == nil
    }
    
    @discardableResult
    class func traverse(head: Node<T>?) -> [T]{
        var result = [T]()
        guard let head = head else {
            print("The linked list is empty!")
            return result
        }
        var currentNode: Node? = head
        while currentNode != nil {
            result.append(currentNode!.value)
            currentNode = currentNode!.nextNode
        }
        return result
    }
}
