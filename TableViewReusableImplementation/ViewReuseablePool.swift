//
//  ViewReuseablePool.swift
//  TableViewReusableImplementation
//
//  Created by Chung Han Hsin on 2021/1/12.
//

import UIKit

protocol ReusablePool {
    func dequeuReusableView(id: String, handleView: () -> UIView) -> UIView
    func addUsingView(id: String, view: UIView)
    func addWaitingView(id: String, view: UIView)
    func reset()
}

class ReusableQueue {
    var id: String
    var queue = DoublyLinkedList<UIView>()
    init(id: String) {
        self.id = id
    }
    
    func enqueue(view: UIView) {
        queue.push(value: view)
    }
    
    func dequeue() -> UIView?{
        return queue.popNode()
    }
    
    func dequeueAll() -> [UIView]? {
        return queue.popAll()
    }
    
    func enqueuAll(views: [UIView]) {
        queue.push(values: views)
    }
}


class ViewReuseablePool: ReusablePool {
    
    var waitingQueues = [String: ReusableQueue]()
    var usingQueues = [String: ReusableQueue]()
    
    enum QueuesType  {
        case Waiting
        case Using
    }
    
    func dequeuReusableView(id: String, handleView: () -> UIView) -> UIView {
        guard let waitQueue = waitingQueues[id], let usingQueue = usingQueues[id] else {
            let view = handleView()
            let usingQueue = ReusableQueue(id: id)
            usingQueue.enqueue(view: view)
            usingQueues[id] = usingQueue
            
            let waitingQueue = ReusableQueue(id: id)
            waitingQueues[id] = waitingQueue
            print("generate \(id) UsingQueue and WaitingQueue!")
            return view
        }
        
        guard let view = waitQueue.dequeue() else {
            let view = handleView()
            usingQueue.enqueue(view: view)
            print("Queue \(id) is empty, so generate a view for you")
            return view
        }
        
        usingQueue.enqueue(view: view)
        return view
    }
    
    func addWaitingView(id: String, view: UIView) {
        guard let waitingQueue = waitingQueues[id], let usingQueue = usingQueues[id] else {
            return
        }
        usingQueue.dequeue()
        waitingQueue.enqueue(view: view)
    }
    
    func addUsingView(id: String, view: UIView) {
        guard let queue = usingQueues[id] else {
            return
        }
        queue.enqueue(view: view)
    }
    
    func reset() {
        for (_, usingQueue) in usingQueues {
            let usingQueueId = usingQueue.id
            guard let waitingQueue = waitingQueues[usingQueueId] else {
                print("Can not find \(usingQueueId) in waitingQueues")
                return
            }
            
            guard let views = usingQueue.dequeueAll() else {
                print("The usingQueue is empty!")
                return
            }
            
            waitingQueue.enqueuAll(views: views)
        }
    }
    
    func isQueueExisted(id: String, type: QueuesType) -> Bool {
        let queues: [String: ReusableQueue]
        switch type {
        case .Using:
            queues = usingQueues
        case .Waiting:
            queues = waitingQueues
        }
        guard let _ = queues[id] else {
            return false
        }
        return true
    }
    
    func traverseQueues(ids: String..., type: QueuesType) -> [String] {
        var result = [String]()
        for id in ids {
            if isQueueExisted(id: id, type: type) {
                let usingQueue = usingQueues[id]!
                result.append(usingQueue.id)
            }
        }
        return result
    }

}
