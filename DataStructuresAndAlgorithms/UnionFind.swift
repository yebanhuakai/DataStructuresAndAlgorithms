//
//  UnionFind.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

// MARK: - Union Find 并查集
class UnionFind {
    var parent:[Int]
    var rank:[Int]
    var count = 0
    
    init(count:Int) {
        parent = [Int](sequence(first: 0, next: { $0 < count-1 ? $0 + 1 : nil }))
        rank = [Int](repeatElement(1, count: count))
        self.count = count
    }
    
    func size() -> Int {
        return count
    }
    
    func isConnected(p:Int, q:Int) -> Bool {
        return findRoot(p) == findRoot(q)
    }
    
    func findRoot(_ p:Int) -> Int {
        guard p >= 0 && p < count else {
            return -1
        }
        
        //如果p的父结点是自己，则一定是根，停止循环并返还，否则递归遍历到根并赋值回来
        if p !=  parent[p] {
            parent[p] = findRoot(parent[p])
        }
        return parent[p]
    }
    
    func union(p:Int, q:Int) {
        let pRoot = findRoot(p)
        let qRoot = findRoot(q)
        
        if pRoot == qRoot {
            return
        }
        
        if rank[pRoot] < rank[qRoot] {
            parent[pRoot] = qRoot
        } else if rank[pRoot] > rank[qRoot]{
            parent[qRoot] = pRoot
        } else {
            parent[pRoot] = qRoot
            rank[qRoot] += 1 //被设为根的rank+1
        }
    }
    
}
