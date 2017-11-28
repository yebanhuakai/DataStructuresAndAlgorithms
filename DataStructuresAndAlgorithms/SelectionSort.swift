//
//  SelectionSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

// MARK: - 排序算法-选择排序：挑选剩余数组里最小的放到前面
func selectionSort<T:Comparable>(arr:inout [T]) { //泛型排序
    
    for i in 0..<arr.count {
        var minIndex = i
        for j in i+1..<arr.count { //注意索引从i+1开始，不然会重复计算i与i比较
            if arr[j] < arr[minIndex] {
                minIndex = j
            }
        }
        arr.swapAt(i, minIndex)
    }
    
}

