//
//  SparseGraph.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

/*
 0 : 1
 1 : 2 3
 2 : 1
 3 : 1
 */
//稀疏图-邻接表
class SparseGraph {
    
    private var n = 0 //顶点
    private var m = 0 //边
    private var directed:Bool //有向无向
    private var g:[[Int]] //邻接表，表示所有与点相邻的其他顶点
    
    init(n:Int, directed:Bool) {
        self.n = n
        self.directed = directed
        g = [[Int]](repeatElement([Int](), count: n)) //初始化就是空，之后是往里添加
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
        
        //平行边的问题是邻接表的缺点，由于数组的contains函数实现复杂度为O(n),所以这里会导致addEdge方法实现复杂度也会提高
        guard !hasEdge(v, w) else {
            return
        }
        
        g[v].append(w)
        if v != w && !directed { //防止自环边
            g[w].append(v)
        }
        m += 1
    }
    
    func hasEdge(_ v:Int, _ w:Int) -> Bool {
        
        guard (v >= 0 && v < n) && (w >= 0 && w < n) else {
            return false
        }
        
        return g[v].contains(w) //O(n)级别
    }
    
    //外部访问迭代器，用于遍历临边
    func adjIterator(v:Int) -> [Int] {
        return g[v]
    }
    
    
}

