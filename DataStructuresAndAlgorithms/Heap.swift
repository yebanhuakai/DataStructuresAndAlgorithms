//
//  Heap.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

//heap sort 堆
class MaxHeap<T:Comparable> {
    
    var count = 0
    var data:[T]
    
    init(data:[T], count:Int) {
        self.data = Array(repeatElement(data[0], count: count + 1))
        self.count = count
        for i in 0..<count {
            self.data[i+1] = data[i]
        }
        
        var j = count / 2
        while j >= 1 {
            self.shiftDown(k: j)
            j -= 1
        }
    }
    
    func size() -> Int {
        return count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func insert(item:T) -> () {
        data[count + 1] = item
        count += 1
        shipUp()
    }
    
    //比父节点大就上移
    func shipUp() -> () {
        var k = count
        while k > 1 && data[k] > data[k / 2] {
            data.swapAt(k / 2, k)
            k /= 2
        }
    }
    
    //比子节点小，就下移，即删除操作
    func shiftDown(k:Int) {
        
        var k = k
        
        while k * 2 <= count {
            
            //先判断有没有右节点，如果有，和左节点比大小，如果左比右小，则右移j
            var j = k * 2
            if j + 1 <= count && data[j] < data[j + 1] {
                j += 1
            }
            
            if data[k] > data[j] {
                break
            }
            
            data.swapAt(k, j) //可优化，仅需兑换最后一次即可
            k = j
        }
        
    }
    
    func extractMax() -> T {
        let ret = data[1]
        data.swapAt(1, count)
        count -= 1
        shiftDown(k: 1)
        return ret
    }
    
    //自动以完全二叉堆的格式打印：
    func testPrint() -> () {
        
        //打印堆结构，首先，过滤0位置，从1开始，前面加空格，为logN个，
        
        let lines = Int(round((log2(Double(count))))) //先求出共多少行:5
        var printLines = lines
        
        for i in 1...lines {
            
            var str = ""
            
            //每行需要打印的数据个数1,2,4,8
            let needNum = (pow(2, i - 1) as NSDecimalNumber).intValue
            
            //前面需要多少空格
            for _ in 1..<(pow(2, lines - i) as NSDecimalNumber).intValue {
                str.append("  ") //前缀拼接多少空格, 为7,3,1,0
            }
            
            //每个数据后面需要多少空格
            let lastSpaceNum = (pow(2, lines - i + 1) as NSDecimalNumber).intValue - 1
            var lastSpaceStr = ""
            for _ in 1...lastSpaceNum {
                lastSpaceStr.append("  ")
            }
            
            //如果是最后一行，需要计算和满二叉树相差几个，减去此数，防止越界
            let tailNum = (i == lines ? (pow(2, lines) as NSDecimalNumber).intValue - 1 - count: 0)
            
            for k in 0..<needNum - tailNum {
                str.append(String(format: "%.2d", (data[k + needNum] as? Int)!) + lastSpaceStr) //15,7,3,1
            }
            
            print(str)
            print("")
            
            printLines -= 1
        }
        
    }
    
}

//数组堆排序，注意索引从0开始
func heapSort<T:Comparable>(arr:inout [T]) {
    
    //1.进行堆排序
    var i = (arr.count - 1) / 2
    while i >= 0 {
        __shiftDown(arr: &arr, n: arr.count, k: i)
        i -= 1
    }
    
    //2.从小到大排序
    var j = arr.count - 1
    while j > 0 {
        arr.swapAt(0, j)
        __shiftDown(arr: &arr, n: j, k: 0)
        j -= 1
    }
    
}

//n：共多少元素， k：当前需要检查的元素序号__shiftDown(arr, n, i)
func __shiftDown<T:Comparable>(arr:inout [T], n:Int, k:Int) {
    
    var k = k
    
    while k * 2 + 1 < n {
        
        //先判断有没有右节点，如果有，和左节点比大小，如果左比右小，则右移j
        var j = k * 2 + 1
        if j + 1 < n && arr[j] < arr[j + 1] {
            j += 1
        }
        
        if arr[k] > arr[j] {
            break
        }
        
        arr.swapAt(k, j) //可优化，仅需兑换最后一次即可
        k = j
    }
    
}

//由于C++可以支持先创建指定空间大小的空数组，但是Swift不可以，所以此方法无意义
func heapSort1<T:Comparable>(arr:inout [T]) {
    let maxHeap = MaxHeap(data: arr, count: arr.count)
    for i in 0..<arr.count {
        maxHeap.insert(item: arr[i])
    }
    
    var j = arr.count - 1
    while j >= 0 {
        arr[j] = maxHeap.extractMax()
        j -= 1
    }
}

//heapify
func heapSort2<T:Comparable>(arr:inout [T]) {
    let maxHeap = MaxHeap(data: arr, count: arr.count)
    
    var j = arr.count - 1
    while j >= 0 {
        arr[j] = maxHeap.extractMax()
        j -= 1
    }
}



