//
//  BubbleSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/11/28.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

///冒泡排序，循环依次比较两个元素，将大的后移，直到最大的放到最后
func bubbleSort(arr:inout [Int]) -> [Int] {
    for i in 0..<arr.count {
        for j in 0..<arr.count - i - 1 {
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
            }
        }
    }
    
    return arr
}
