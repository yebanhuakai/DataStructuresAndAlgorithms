//
//  QuickSort.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

// MARK: - 快速排序
func quickSort<T:Comparable>(arr:inout [T]) {
    __quickSort(arr: &arr, l: 0, r: arr.count - 1)
}

func __quickSort<T:Comparable>(arr:inout [T], l:Int, r:Int) {
    
    guard l < r else {
        return
    }
    
    //    if r - l <= 15 {
    //        insertionSort(arr: &arr)
    //        return
    //    }
    
    let p = __partion2(arr: &arr, l: l, r: r) //用于拆分位置
    __quickSort(arr: &arr, l: l, r: p-1)
    __quickSort(arr: &arr, l: p+1, r: r)
}

//对arr[l...r]部分进行partition操作
//返回P，使得arr[l...p-1] < arr[p]; arr[p+1...r] > arr[p]
func __partion<T:Comparable>(arr:inout [T], l:Int, r:Int) -> Int {
    
    arr.swapAt(l, Int(arc4random()) % (r - l + 1) + l) //对于有序数组，随机选v速度更快，且时间复杂度退化到O(n²)的概率近乎为零
    let v = arr[l]
    
    //1.单路排序
    var j = l
    for i in l+1...r {
        if arr[i] < v {
            arr.swapAt(j+1, i)
            j += 1
        }
    }
    
    arr.swapAt(l, j)
    return j
}

//arr[l+1...i) <= v; arr(j...r] >= v
func __partion2<T:Comparable>(arr:inout [T], l:Int, r:Int) -> Int {
    arr.swapAt(l, Int(arc4random()) % (r - l + 1) + l) //对于有序数组，随机选v速度更快，且时间复杂度退化到O(n²)的概率近乎为零
    let v = arr[l]
    
    //2.双路排序
    var i = l + 1, j = r
    while true {
        while i <= r && arr[i] < v { i += 1 }
        while j >= l + 1 && arr[j] > v { j -= 1 }
        if i > j { break }
        
        arr.swapAt(i, j)
        i += 1
        j -= 1
    }
    
    arr.swapAt(l, j)
    
    return j
    
}

//var quickArr = randomArr(count: count1_000_000, rangeL: 0, rangeR: count1_000_000)
//var quickArr = randomNearlyOrderArr(count: count1_000_000, swapTimes: 100)
//var quickArr1 = quickArr
//var quickArr2 = quickArr
//
//timeClac(fn: quickSort(arr:), arr: &quickArr1, funcName: "QuickSort ") //快速排序对于近乎有序的排序较慢，对大量随机的则能高效排序
//print(quickArr1[0...49])
//timeClac(fn: mergeSort(arr:), arr: &quickArr2, funcName: "MergeSort ") //对于少量数据，优势不明显
//print(quickArr2[0...49])

//快速三路排序算法
func quickSort3Way<T:Comparable>(arr:inout [T]) {
    __quickSort3Way(arr: &arr, l: 0, r: arr.count - 1)
}

func __quickSort3Way<T:Comparable>(arr:inout [T], l:Int, r:Int) {
    
    guard l < r else {
        return
    }
    
    //    print("start:", arr[l...r])
    
    arr.swapAt(l, Int(arc4random()) % (r - l + 1) + l) //对于有序数组，随机选v速度更快，且时间复杂度退化到O(n²)的概率近乎为零
    let v = arr[l]
    
    //arr[l+1...lt] < v ; [lt + 1...i-1] == v ; arr[gt...r] > v
    var lt = l
    var gt = r + 1
    var i = l + 1
    
    while i < gt {
        if arr[i] < v {
            arr.swapAt(lt + 1, i)
            
            lt += 1
            i += 1
        }
        else if arr[i] > v {
            arr.swapAt(gt - 1, i)
            
            gt -= 1 //这里i不动，因为交换过的元素要接下来继续判断
        } else {
            i += 1
        }
    }
    
    arr.swapAt(l, lt)
    
    __quickSort3Way(arr: &arr, l: l, r: lt - 1) //注意上步交换之后，没有进行减减操作
    __quickSort3Way(arr: &arr, l: gt, r: r)
}

//逆序对 ⭐️作业 （归并算法）
//第n大元素 ⭐️作业 （快速排序算法）
