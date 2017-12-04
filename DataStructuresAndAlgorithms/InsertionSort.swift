//
//  InsertionSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

// MARK: - 插入排序：将比当前检查元素大的前面元素后移，直到遇到比当前检查元素小的，最后把当前元素插入
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

//Bubble Sort ⭐️作业
//Shell Sort ⭐️作业
