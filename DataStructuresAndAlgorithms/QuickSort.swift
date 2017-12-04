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

private func __quickSort<T:Comparable>(arr:inout [T], l:Int, r:Int) {
    
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
private func __partion<T:Comparable>(arr:inout [T], l:Int, r:Int) -> Int {
    
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
private func __partion2<T:Comparable>(arr:inout [T], l:Int, r:Int) -> Int {
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

//--------------------------------------------------------------------------------
// 求无序数组第几大元素
func kthBigestElement<T:Comparable>(arr:inout [T], k:Int) -> T? {
    return __KthBigestElement(arr: &arr, l: 0, r: arr.count-1, k: arr.count - k)
}

//返回指定的第几大元素。例：[3,4,2,1,6,7,5],第二大元素为6,k=2
private func __KthBigestElement<T:Comparable>(arr:inout [T], l:Int, r:Int, k:Int) -> T? {
    guard l < r else {
        return nil
    }
    
    let p = __partion2(arr: &arr, l: l, r: r) //用于拆分位置
    
    if k == p {
        return arr[p]
    } else if k < p {
        return __KthBigestElement(arr: &arr, l: l, r: p-1, k: k)
    } else {
        return __KthBigestElement(arr: &arr, l: p+1, r: r, k: k)
    }
}

//--------------------------------------------------------------------------------
//快速三路排序算法
func quickSort3Way<T:Comparable>(arr:inout [T]) {
    __quickSort3Way(arr: &arr, l: 0, r: arr.count - 1)
}

private func __quickSort3Way<T:Comparable>(arr:inout [T], l:Int, r:Int) {
    
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

//第n大元素 ⭐️作业 （快速排序算法）
