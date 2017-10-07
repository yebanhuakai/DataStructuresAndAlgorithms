//
//  main.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/9/29.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

//------------------------------♨️---------------------------------//



//------------------------------♨️---------------------------------//


//------------------------------♨️---------------------------------//



//------------------------------♨️---------------------------------//



//------------------------------♨️---------------------------------//
//BinarySearchTree
let bst = BST<Int,Int>()

let testBSTArr = [28, 16, 30, 13, 22, 29, 42]

for i in testBSTArr {
    let node = BST<Int, Int>.Node(key: i, value: i)
    bst.insert(key: node.key, value: node.value)
}
//
//bst.preOrder()
//print("\n")
//bst.inOrder()
//print("\n")
//bst.postOrder()
//print("\n")
//bst.levelOrder()

//------------------------------♨️---------------------------------//
//UnionFind
#if false
let uf = UnionFind(count: count1_000_000)

let timeStart = Date()

for _ in 0..<count1_000_000 {
    let a = Int(arc4random()) % count1_000_000
    let b = Int(arc4random()) % count1_000_000
    uf.union(p: a, q: b)
}

for _ in 0..<count1_000_000 {
    let a = Int(arc4random()) % count1_000_000
    let b = Int(arc4random()) % count1_000_000
    uf.isConnected(p: a, q: b)
}

let timeEnd = Date()
let seconds = timeEnd.timeIntervalSince(timeStart)
print("Union Find Eclipse time: ", seconds)
#endif
//------------------------------♨️---------------------------------//
// MARK: - 图论 Graph Theory



