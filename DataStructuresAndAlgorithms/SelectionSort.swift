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

