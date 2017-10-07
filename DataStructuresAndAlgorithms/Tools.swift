//
//  Tools.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

let count1_000_000 = 1_000_000
let count500_000 = 500_000
let count100_000 = 100_000

//随机生成函数
func randomArr(count:Int, rangeL:Int, rangeR:Int) -> [Int] {
    
    guard count > 0, rangeL >= 0, rangeL < rangeR else {
        return []
    }
    
    var arr = Array(repeatElement(0, count: count))
    
    for i in 0..<count {
        arr[i] = Int(arc4random()) % (rangeR - rangeL + 1) + rangeL
    }
    
    return arr
}

//随机生成近乎有序数组
func randomNearlyOrderArr(count:Int, swapTimes:Int) -> [Int] {
    
    var arr = Array(repeatElement(0, count: count))
    for i in 0..<count {
        arr[i] = i
    }
    
    for _ in 0..<swapTimes {
        let posA = Int(arc4random()) % count
        let posB = Int(arc4random()) % count
        arr.swapAt(posA, posB)
    }
    
    return arr
}

//包装泛型函数的高阶函数，用于打印时间
func timeClac<T:Comparable>(fn:(inout [T])->(), arr:inout [T], funcName:String) {
    let timeStart = Date()
    
    fn(&arr)
    
    let timeEnd = Date()
    let seconds = timeEnd.timeIntervalSince(timeStart)
    print(funcName + " Eclipse time: ", seconds)
}

//Stack，栈满足性质为后进先出
class Stack {
    var stack:[AnyObject]
    
    init() {
        stack = [AnyObject]()
    }
    
    func isEmpty() -> Bool {
        return stack.count == 0
    }
    
    func size() -> Int {
        return stack.count
    }
    
    //push
    func push(object:AnyObject) {
        stack.append(object)
    }
    
    //pop
    func pop() -> AnyObject? {
        
        guard !isEmpty() else {
            return nil
        }
        
        return stack.removeLast()
    }
    
    func top() -> AnyObject? {
        return stack.last
    }
    
}

//Queue，队列满足的性质为，先进先出
class Queue {
    var queue:[AnyObject]
    init() {
        queue = [AnyObject]()
    }
    
    func size() -> Int {
        return queue.count
    }
    
    func isEmpty() -> Bool {
        return queue.count == 0
    }
    
    //入队
    func enqueue(object:AnyObject) {
        queue.append(object)
    }
    
    //出队
    func dequeue() -> AnyObject? {
        
        guard !isEmpty() else {
            return nil
        }
        
        return queue.removeFirst()
    }
    
    func top() -> AnyObject? {
        return queue.first
    }
    
}
