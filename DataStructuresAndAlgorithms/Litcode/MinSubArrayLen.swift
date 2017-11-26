//
//  MinSubArrayLen.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/11/26.
//  Copyright © 2017年 Shenry. All rights reserved.
//

///LeetCode209,FB,寻找连续数组中满足元素和>=s的最小连续子数组的个数
///“滑动窗口”解法
import Foundation

func minSubArrayLen(arr: [Int], s: Int) -> Int {

    var l = 0, r = -1 //arr[l...r]为滑动窗口
    var sum = 0
    var res = arr.count + 1 //设定一个不可能到达的值
    
    while l < arr.count {
        if r + 1 < arr.count && sum < s {
            r += 1
            sum += arr[r]
        } else {
            sum -= arr[l]
            l += 1
        }
        
        if sum >= s {
            res = min(res, r-l+1)
        }
    }
    
    if res == arr.count + 1 {
        return 0
    }
    
    return res
}
