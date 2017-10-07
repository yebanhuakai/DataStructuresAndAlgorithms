//
//  ShortestPath.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

//计算最短路径
class ShortestPath {
    
    var source = 0 //起始点
    var G:Graph
    var visited:[Bool] //被访问过的定点
    var from:[Int] //每个点从哪来的，用来倒推路径
    var ord:[Int] //source节点到每个节点的最短距离
    
    init?(G:Graph, source:Int) {
        
        guard source >= 0 && source < G.V() else {
            return nil
        }
        
        self.G = G
        self.source = source
        visited = [Bool](repeatElement(false, count: G.V()))
        from = [Int](repeatElement(-1, count: G.V()))
        ord = [Int](repeatElement(-1, count: G.V()))

        let q = Queue()
        //无向图最短优先路径
        q.enqueue(object: source as AnyObject)
        visited[source] = true
        ord[source] = 0
        
        //广度优先遍历，层层遍历，用队列实现较为容易
        while !q.isEmpty() {
            let v = q.dequeue() as! Int
            let adj = G.adjIterator(v: v)
            for i in adj {
                if !visited[i] {
                    q.enqueue(object: i as AnyObject)
                    visited[i] = true
                    from[i] = v
                    ord[i] = ord[v] + 1
                }
            }
        }
    }
    
    //返回source点到w点之间的最短路径
    func length(w:Int) -> Int {
        
        guard w >= 0 && w < G.V() else {
            return -1
        }
        
        return ord[w]
    }
    
    func hasPath(w:Int) -> Bool {
        guard w >= 0 && w < G.V() else {
            return false
        }
        return visited[w] //如果被访问过，一定存在此路径
    }
    
    func path(w:Int, vec:inout [Int]) {
        //利用栈，倒序放入再正序取出即是路径顺序
        let stack = Stack()
        var w = w
        while w != -1 {
            stack.push(object: w as AnyObject)
            w = from[w]
        }
        
        vec.removeAll()
        while !stack.isEmpty() {
            vec.append(stack.pop() as! Int)
        }
    }
    
    func showPath(w:Int) {
        var vec = [Int]()
        path(w: w, vec: &vec)
        
        for i in 0..<vec.count {
            if i != vec.count - 1 {
                print(vec[i], terminator: " -> ")
            } else {
                print(vec[i])
            }
        }
    }
}
