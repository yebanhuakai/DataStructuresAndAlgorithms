//
//  Component.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

class Component {
    var G:Graph
    var visited:[Bool] //被访问过的定点
    var ccount = 0 //连通分量数
    
    init(G:Graph) {
        self.G = G
        visited = [Bool](repeatElement(false, count: G.V()))
        
        for i in 0..<G.V() {
            if !visited[i] {
                dfs(v: i)
                ccount += 1 //如果该点没被上面步骤访问过，则一定是新的连通分量
            }
        }
    }
    
    func count() -> Int {
        return ccount
    }
    
    //depth first search
    func dfs(v:Int) {
        visited[v] = true
        let w = G.adjIterator(v: v)
        for i in w {
            if !visited[i] {
                dfs(v: i) //如果该点没有被遍历过，就继续遍历该点的连接点
            }
        }
    }
}
