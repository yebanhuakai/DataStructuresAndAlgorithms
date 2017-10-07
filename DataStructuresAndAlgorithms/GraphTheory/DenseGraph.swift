//
//  DenseGraph.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

/*
   0 1 2 3
 0 f f f f
 1 t t t t
 2 f f f f
 3 t t t t
 */
//稠密图-邻接矩阵
class DenseGraph {
   
    var n = 0 //顶点
    var m = 0 //边
    var directed:Bool //有向无向
    var g:[[Bool]] //邻接矩阵
    
    init(n:Int, directed:Bool) {
        self.n = n
        self.directed = directed
        g = [[Bool]](repeatElement([Bool](repeatElement(false, count: n)), count: n))
    }
 
    func V() -> Int {
        return n
    }
    
    func E() -> Int {
        return m
    }
    
     //为v和w两个定点之间增加一条边
    func addEdge(v:Int, w:Int) {
        guard (v >= 0 && v < n) && (w >= 0 && w < n) else {
            return
        }
        
        guard !hasEdge(v, w) else {
            return
        }
        
        g[v][w] = true //同时防止平行边
        if !directed {
            g[w][v] = true
        }
        m += 1
    }
    
    func hasEdge(_ v:Int, _ w:Int) -> Bool {
        
        guard (v >= 0 && v < n) && (w >= 0 && w < n) else {
            return false
        }
        
        return g[v][w] //O(1)级别
    }

    //外部访问迭代器，用于遍历临边
    func adjIterator(v:Int) -> [Int] {
        //只返回结果为true的
        var arr = [Int]()
        let w = g[v]
        for i in 0..<w.count {
            if w[i] == true {
                arr.append(i)
            }
        }
        
        return arr
    }
    
}
