//
//  main.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/9/29.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

//------------------------------♨️---------------------------------//
//SelectionSort
#if false

var arr = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
selectionSort(arr: &arr)

var strArr = ["e", "d", "c", "b", "a"]
selectionSort(arr: &strArr)

var floatArr = [5.4321, 4.321, 3.21, 2.1, 1.0]
selectionSort(arr: &floatArr)

struct Student:Comparable, Equatable {
    let name:String
    var score:Int

    static func <(lhs: Student, rhs: Student) -> Bool {
        return lhs.score > rhs.score
    }

    static func ==(lhs: Student, rhs: Student) -> Bool {
        return lhs.score == rhs.score
    }

}

var structArr = [
    Student(name: "Yuemeng", score: 100),
    Student(name: "MengGe", score: 99),
    Student(name: "Tiankun", score: 59),
    Student(name: "Laosha", score: 1)
]

selectionSort(arr: &structArr)

var randArr = randomArr(count: 1_000, rangeL: 9, rangeR: 1_000) //100个随机数排序时间：0.240666，1000个：4.075919， O(n²)级别
selectionSort(arr: &randArr)
print(randArr[0...100])

#endif

//------------------------------♨️---------------------------------//
//InsertionSort
#if false

var insertArr = randomArr(count: 100, rangeL: 0, rangeR: 10) //插入排序对于范围小、连续度高的数组排序比选择更快
var arrCP1 = insertArr
var arrCP2 = insertArr

timeClac(fn: selectionSort(arr:), arr: &arrCP1, funcName: "SelectionSort") //注意函数类型调用方法
timeClac(fn: insertionSort(arr:), arr: &arrCP1, funcName: "insertionSort1")
print(arrCP1[0...99])
timeClac(fn: insertionSort2(arr:), arr: &arrCP2, funcName: "insertionSort2")
print(arrCP2[0...99])


var newArr = randomNearlyOrderArr(count: count100_000, swapTimes: 10)
var newArr1 = newArr
var newArr2 = newArr

timeClac(fn: selectionSort(arr:), arr: &newArr1, funcName: "SelectionSort") //注意函数类型调用方法
timeClac(fn: insertionSort(arr:), arr: &newArr2, funcName: "InsertionSort") //连续度高的数组插入更快，因为能提前终止循环
insertArr.sorted(by: <)

#endif

//------------------------------♨️---------------------------------//
//MergeSort
#if false

var mergeArr = randomArr(count: 10000, rangeL: 0, rangeR: 10)
//var mergeArr = randomNearlyOrderArr(count: 15, swapTimes: 7)
var mergeArr1 = mergeArr
var mergeArr2 = mergeArr
print(mergeArr[0...100])
timeClac(fn: insertionSort(arr:), arr: &mergeArr1, funcName: "InsertionSort")
print(mergeArr1[0...14])
timeClac(fn: mergeSort(arr:), arr: &mergeArr2, funcName: "MergeSort ")
print(mergeArr2[0...14])

#endif

//------------------------------♨️---------------------------------//
//QuickSort
#if false

var quick3Arr = randomNearlyOrderArr(count: count1_000_000, swapTimes: 10)
var quick3Arr1 = quick3Arr
var quick3Arr2 = quick3Arr
var quick3Arr3 = quick3Arr

timeClac(fn: quickSort(arr:), arr: &quick3Arr1, funcName: "QuickSort ")
print(quick3Arr1[0...49])
timeClac(fn: quickSort3Way(arr:), arr: &quick3Arr2, funcName: "Quick3Sort ")
print(quick3Arr2[0...49])
timeClac(fn: mergeSort(arr:), arr: &quick3Arr3, funcName: "MergeSort ")
print(quick3Arr3[0...49])
    
//kth bigest element
var quick3Arr4 = [3,1,2,7,5,6,4]
let k = 2
let p = kthBigestElement(arr: &quick3Arr4, k: k)
print("The \(k)th bigest element is:", p ?? -1)
#endif

//------------------------------♨️---------------------------------//
//Heap
#if false

let n = 16 //最大129，否则无法显示
var heapArr = randomArr(count: count1_000_000, rangeL: 0, rangeR: count1_000_000)
var heapArr1 = heapArr
var heapArr2 = heapArr
var heapArr3 = heapArr

timeClac(fn: heapSort2(arr:), arr: &heapArr1, funcName: "HeapSort2") //heapify过程O(n)级别,但需额外空间
print(heapArr1[0...49])

timeClac(fn: quickSort3Way(arr:), arr: &heapArr2, funcName: "Quick3Sort")
print(heapArr2[0...49])

timeClac(fn: heapSort(arr:), arr: &heapArr3, funcName: "HeapSort") //数组本地操作
print(heapArr3[0...49])

#endif

//------------------------------♨️---------------------------------//
//IndexMaxHeap
#if false

var indexHeapArr = randomArr(count: 64, rangeL: 0, rangeR: 99)
var indexMaxHeap = IndexMaxHeap<Int>(capacity: indexHeapArr.count)

for i in 0..<indexHeapArr.count {
    indexMaxHeap.insert(i: i, item: indexHeapArr[i])
}
indexMaxHeap.testPrint(inMaxIndex: true)
print("\n\n\n")
indexMaxHeap.testPrint(inMaxIndex: false)

#endif

//------------------------------♨️---------------------------------//
//BinarySearch
#if false

var binarySearchArr = randomArr(count: 64, rangeL: 0, rangeR: 64)
quickSort3Way(arr: &binarySearchArr)
print(binarySearchArr)
let target = binarySearch(arr: binarySearchArr, n: binarySearchArr.count, target: 55)
print("Target is :", target)
let targetRe = binarySearchRecursion(arr: binarySearchArr, l: 0, r: binarySearchArr.count - 1, target: 55)
print("Recursion Target is :", targetRe)

#endif

//------------------------------♨️---------------------------------//
//BinarySearchTree
#if false
    
let bst = BST<Int,Int>()

let testBSTArr = [28, 16, 30, 13, 22, 29, 42]

for i in testBSTArr {
    let node = BST<Int, Int>.Node(key: i, value: i)
    bst.insert(key: node.key, value: node.value)
}

bst.preOrder()
print("\n")
bst.inOrder()
print("\n")
bst.postOrder()
print("\n")
bst.levelOrder()
    
#endif
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

#if false

let n = 20, m = 100
    
print("\nSparseGraph:")

let sparseGraph = SparseGraph(n: n, directed: false)
for _ in 0..<m {
    let a = Int(arc4random()) % n
    let b = Int(arc4random()) % n
    sparseGraph.addEdge(v: a, w: b)
}
    
for i in 0..<n {
    let w = sparseGraph.adjIterator(v: i)
    print("\(i) :", w)
}
    
print("\nDenseGraph:")
    
let denseGraph = DenseGraph(n: n, directed: false)
for _ in 0..<m {
    let a = Int(arc4random()) % n
    let b = Int(arc4random()) % n
    denseGraph.addEdge(v: a, w: b)
}
    
for i in 0..<n {
    let w = denseGraph.adjIterator(v: i)
    print("\(i) :", w)
}

#endif

//图的完全遍历

#if false
    
let n = 13
    
print("\nSparseGraph, AdjacencyLists:")

let sparseGraph = SparseGraph(n: 13, directed: false)
for tuple in G1 {
    sparseGraph.addEdge(v: tuple.v1, w: tuple.v2)
}
sparseGraph.show()
    
print("\nDenseGraph, AdjacencyMatrix:")

let denseGraph = DenseGraph(n: 7, directed: false)
for tuple in G1 {
    denseGraph.addEdge(v: tuple.v1, w: tuple.v2)
}
denseGraph.show()
    
#endif

//广度优先遍历
#if false

let sparseGraph1 = SparseGraph(n: 13, directed: false)
for tuple in G1 {
    sparseGraph1.addEdge(v: tuple.v1, w: tuple.v2)
}
    
let component1 = Component(G: sparseGraph1)
    
print("component1.count:", component1.count())
    
let sparseGraph2 = SparseGraph(n: 7, directed: false)
for tuple in G2 {
    sparseGraph2.addEdge(v: tuple.v1, w: tuple.v2)
}
    
let component2 = Component(G: sparseGraph2)

print("component2.count:", component2.count())

#endif

//DFS vs BFS
#if false
    
let sparseGraph = SparseGraph(n: 7, directed: false)
for tuple in G2 {
    sparseGraph.addEdge(v: tuple.v1, w: tuple.v2)
}
sparseGraph.show()
    
let path = Path(G: sparseGraph, source: 0)
path?.showPath(w: 6)
    
let shortestPath = ShortestPath(G: sparseGraph, source: 0)
shortestPath?.showPath(w: 6)
    
#endif

//------------------------------♨️---------------------------------//
//LeetCode

//209
#if false

let arr = [2,3,1,2,4,3]
    
let res = minSubArrayLen(arr: arr, s: 7)
    
print(res)

#endif

var arr = randomArr(count: 100, rangeL: 0, rangeR: 1_000)

//print(bubbleSort(arr: &arr))
print(insertionSortTest(arr: &arr))
