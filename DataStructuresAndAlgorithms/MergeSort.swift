//
//  MergeSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

// MARK: - 思路：不断平分至无法再平分，然后将剩余部分排序
func mergeSort<T:Comparable>(arr:inout [T]) {
    __mergeSort(arr: &arr, l:0, r:arr.count - 1) //索引位置
    //    __mergeSortBU(arr: &arr, l: 0, r: arr.count - 1)
}

//递归使用归并排序，自顶向下
func __mergeSort<T:Comparable>(arr:inout [T], l:Int, r:Int) { //[1,4,3,2]
    
    //保证元素至少有2个
    guard l < r else {
        return
    }
    
    //    if r - l <= 15 {
    //        insertionSort(arr: &arr)
    //        return
    //    }
    
    let mid = l + (r - l) / 2
    
    __mergeSort(arr: &arr, l: l, r: mid) //0, 1
    __mergeSort(arr: &arr, l: mid + 1, r: r) // 2,3
    
    //当最终元素只有两个时，即是左右元素比大小，如果小于等于，说明已经排好了
    if arr[mid] > arr[mid+1] {
        __merge(arr: &arr, l: l, mid: mid, r: r)
    }
}

//将arr[l...mid]和arr[mid+1...r]两部分进行归并
//[0,1,2,3], mid = 1
func __merge<T:Comparable>(arr:inout [T], l:Int, mid:Int, r:Int) {
    
    //开辟临时数组，长度为出入的数组区间，注意赋值时坐标从0开始，要减去l
    var aux = Array(repeatElement(arr[0], count: r - l + 1))
    for i in l...r {
        aux[i-l] = arr[i]
    }
    
    //给temp数组设置遍历下标，注意起始从0开始，需要减去l
    var i = l, j = mid + 1
    
    //对原数组进行遍历
    for k in l...r {
        
        if i > mid {
            //如果左边都遍历完了，直接复制右部
            arr[k] = aux[j-l]
            j += 1
        } else if j > r {
            //如果右边都遍历完了，直接复制左部
            arr[k] = aux[i-l]
            i += 1
        } else if aux[i-l] < aux[j-l] {
            arr[k] = aux[i-l]
            i += 1
        } else {
            arr[k] = aux[j-l]
            j += 1
        }
    }
}

//自底向上
func __mergeSortBU<T:Comparable>(arr:inout [T], l:Int, r:Int) {
    
    let n = arr.count
    for var sz in 1...n {
        var i = 0;
        while i + sz < n {
            __merge(arr: &arr, l: i, mid: i + sz - 1, r: min(i + sz + sz - 1, n - 1))
            i += sz + sz
        }
        
        sz += sz
    }
}

//逆序对 ⭐️作业 （归并算法）

