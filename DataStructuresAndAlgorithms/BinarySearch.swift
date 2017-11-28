//
//  BinarySearch.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

// MARK: - Binary Search 二分查找法O(n)，必须是有序数组
func binarySearch<T:Comparable>(arr:[T], n:Int, target:T) -> Int {
    
    var l = 0, r = n - 1
    while l <= r {
        let mid = l + (r - l) / 2
        
        if arr[mid] == target {
            return mid
        } else if target < arr[mid] {
            r = mid - 1
        } else {
            l = mid + 1
        }
    }
    
    return -1
}

//递归方式
func binarySearchRecursion<T:Comparable>(arr:[T], l:Int, r:Int, target:T) -> Int {
    
    if l > r {
        return -1
    }
    
    let mid = l + (r - l) / 2
    if arr[mid] == target {
        return mid
    } else if target < arr[mid] {
        return binarySearchRecursion(arr: arr, l: 0, r: mid - 1, target: target)
    } else {
        return binarySearchRecursion(arr: arr, l: mid + 1, r: r, target: target)
    }
}


