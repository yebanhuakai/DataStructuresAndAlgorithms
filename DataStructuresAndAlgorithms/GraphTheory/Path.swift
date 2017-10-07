//
//  Path.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

class Path {
    
    var source = 0 //起始点
    var G:Graph
    var visited:[Bool] //被访问过的定点
    var from:[Int] //每个点从哪来的，用来倒推路径
    
    init?(G:Graph, source:Int) {
        
        guard source >= 0 && source < G.V() else {
            return nil
        }
        
        self.G = G
        self.source = source
        visited = [Bool](repeatElement(false, count: G.V()))
        from = [Int](repeatElement(-1, count: G.V()))

        //寻路算法
        dfs(v: source)
    }
    
    //depth first search
    private func dfs(v:Int) {
        visited[v] = true
        let w = G.adjIterator(v: v)
        
        for i in w {
            if !visited[i] {
                from[i] = v //i 均是从 v遍历过来的
                dfs(v: i) //利用递归，如果该点没有被遍历过，就继续遍历该点的连接点
            }
        }
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
