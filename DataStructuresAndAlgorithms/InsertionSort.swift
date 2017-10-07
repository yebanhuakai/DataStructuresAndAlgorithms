//
//  InsertionSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

// MARK: - 插入排序：如果后面的比前面的小，就把大于后面的全部后移，最后将其拿到前面
func insertionSort<T:Comparable>(arr:inout [T]) {
    
    for i in 1..<arr.count { //注意从1开始
        let e = arr[i] //需要检查的元素
        
        var j = i
        
        while j >= 1 && arr[j - 1] > e {
            arr[j] = arr[j - 1]
            j -= 1
        }
        
        arr[j] = e
    }
    
}

func insertionSort2<T:Comparable>(arr:inout [T]) {
    
    for i in 1..<arr.count { //注意从1开始
        let e = arr[i] //需要检查的元素
        
        var index = i //注意，此处外面不可以定义j，里面的j与外面的j系统会认为是两个
        for j in (1...i).reversed() where arr[j - 1] > e { //j-1是0，所以必须从1开始.提前终止内存循环是插入排序非常重要的性质
            
            arr[j] = arr[j - 1]
            index = j - 1 //记录最后一个比e大的索引，就是需要赋值到e的索引
        }
        
        arr[index] = e
    }
}

//var insertArr = randomArr(count: 100, rangeL: 0, rangeR: 10) //插入排序对于范围小、连续度高的数组排序比选择更快
//var arrCP1 = insertArr
//var arrCP2 = insertArr
//
//timeClac(fn: selectionSort(arr:), arr: &arrCP1, funcName: "SelectionSort") //注意函数类型调用方法
//timeClac(fn: insertionSort(arr:), arr: &arrCP1, funcName: "insertionSort1")
//print(arrCP1[0...99])
//timeClac(fn: insertionSort2(arr:), arr: &arrCP2, funcName: "insertionSort2")
//print(arrCP2[0...99])


//var newArr = randomNearlyOrderArr(count: count100_000, swapTimes: 10)
//var newArr1 = newArr
//var newArr2 = newArr
//
//timeClac(fn: selectionSort(arr:), arr: &newArr1, funcName: "SelectionSort") //注意函数类型调用方法
//timeClac(fn: insertionSort(arr:), arr: &newArr2, funcName: "InsertionSort") //连续度高的数组插入更快，因为能提前终止循环
//insertArr.sorted(by: <)

//Bubble Sort ⭐️作业
//Shell Sort ⭐️作业
