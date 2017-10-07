//
//  SelectionSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

// MARK: - 排序算法-选择排序：先挑最小的，再挑第二小的...
func selectionSort<T:Comparable>(arr:inout [T]) { //泛型排序
    
    for i in 0..<arr.count {
        var minIndex = i
        for j in i..<arr.count {
            if arr[j] < arr[minIndex] {
                minIndex = j
            }
        }
        arr.swapAt(i, minIndex)
    }
    
}
//
//var arr = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
//selectionSort(arr: &arr)
//arr
//
//var strArr = ["e", "d", "c", "b", "a"]
//selectionSort(arr: &strArr)
//
//var floatArr = [5.4321, 4.321, 3.21, 2.1, 1.0]
//selectionSort(arr: &floatArr)
//
//struct Student:Comparable, Equatable {
//    let name:String
//    var score:Int
//
//    static func <(lhs: Student, rhs: Student) -> Bool {
//        return lhs.score > rhs.score
//    }
//
//    static func ==(lhs: Student, rhs: Student) -> Bool {
//        return lhs.score == rhs.score
//    }
//
//}
//
//var structArr = [
//    Student(name: "Yuemeng", score: 100),
//    Student(name: "MengGe", score: 99),
//    Student(name: "Tiankun", score: 59),
//    Student(name: "Laosha", score: 1)
//]
//
//selectionSort(arr: &structArr)
//structArr
//
//
//var randArr = randomArr(count: 1_000, rangeL: 9, rangeR: 1_000) //100个随机数排序时间：0.240666，1000个：4.075919， O(n²)级别
//selectionSort(arr: &randArr)
//print(randArr[0...100])
