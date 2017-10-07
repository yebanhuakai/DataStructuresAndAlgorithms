//
//  Graph.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

//13个顶点，13条边
let G1:[(v1:Int, v2:Int)] = [
    ( 0, 5),
    ( 4, 3),
    ( 0, 1),
    (09,12),
    ( 6, 4),
    ( 5, 4),
    ( 0, 2),
    (11,12),
    ( 9,10),
    ( 0, 6),
    ( 7, 8),
    ( 9,11),
    ( 5, 3)
]

//7个顶点，8条边
let G2:[(v1:Int, v2:Int)] = [
    ( 0, 1),
    ( 0, 2),
    ( 0, 5),
    ( 0, 6),
    ( 3, 4),
    ( 3, 5),
    ( 4, 5),
    ( 4, 6),
]

//注意是协议，不是类，Swift是一门面向协议编程语言
protocol Graph {
    
    func V() -> Int
    func E() -> Int
    func addEdge(v:Int, w:Int)
    func hasEdge(_ v:Int, _ w:Int) -> Bool
    func show()
    func adjIterator(v:Int) -> [Int]

}
