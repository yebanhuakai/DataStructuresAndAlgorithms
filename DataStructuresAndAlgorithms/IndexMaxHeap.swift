//
//  IndexMaxHeap.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

// MARK: - Index Heap 索引堆和反向查找
/* 内部索引从1开始
 0     1       2       3
 index
 data
 rev
 */
class IndexMaxHeap<T:Comparable> {
    var data:[T?]!
    var indexesMax:[Int]! //代表真正的堆排序，指向data中第几个数据（最大堆索引）
    var indexesMin:[Int]! //（最小堆索引）
    var reverseMax:[Int]! //反向索引代表该数据位于索引中的第几个
    var reverseMin:[Int]! //（最小堆反向索引）
    
    var countMax = 0
    var countMin = 0
    var capacity = 0
    
    func shiftUpMax(k:Int) {
        var k = k
        while k > 1 && data[indexesMax[k / 2]]! < data[indexesMax[k]]! {
            indexesMax.swapAt(k / 2, k)
            reverseMax[indexesMax[k / 2]] = k / 2 //根据特性，反向查找数组的值就是索引号
            reverseMax[indexesMax[k]] = k
            k /= 2
        }
    }
    
    func shiftUpMin(k:Int) {
        var k = k
        while k > 1 && data[indexesMin[k / 2]]! > data[indexesMin[k]]! {
            indexesMin.swapAt(k / 2, k)
            reverseMin[indexesMin[k / 2]] = k / 2 //根据特性，反向查找数组的值就是索引号
            reverseMin[indexesMin[k]] = k
            k /= 2
        }
    }
    
    func shiftDownMax(k:Int) {
        var k = k
        while 2 * k <= countMax {
            var j = 2 * k
            //向下移动时，先检查有没有右孩子，有的话先比较左右
            if j + 1 <= countMax && data[indexesMax[j]]! < data[indexesMax[j + 1]]! {
                j += 1
            }
            
            //如果索引k的值大于j的值，跳过
            if data[indexesMax[k]]! > data[indexesMax[j]]! {
                break
            }
            
            indexesMax.swapAt(k, j)
            reverseMax[indexesMax[k]] = k
            reverseMax[indexesMax[j]] = j
            k = j
        }
    }
    
    func shiftDownMin(k:Int) {
        var k = k
        while 2 * k <= countMin {
            var j = 2 * k
            //向下移动时，先检查有没有右孩子，有的话先比较左右
            if j + 1 <= countMin && data[indexesMin[j]]! > data[indexesMin[j + 1]]! {
                j += 1
            }
            
            //如果索引k的值大于j的值，跳过
            if data[indexesMin[k]]! < data[indexesMin[j]]! {
                break
            }
            
            indexesMin.swapAt(k, j)
            reverseMin[indexesMin[k]] = k
            reverseMin[indexesMin[j]] = j
            k = j
        }
    }
    
    init(capacity:Int) {
        data = [T?](repeatElement(nil, count: capacity + 1)) //内部索引从1开始
        indexesMax = [Int](repeatElement(0, count: capacity + 1))
        indexesMin = [Int](repeatElement(0, count: capacity + 1))
        reverseMax = [Int](repeatElement(0, count: capacity + 1))
        reverseMin = [Int](repeatElement(0, count: capacity + 1))
        
        self.capacity = capacity
    }
    
    func size(isMaxIndex:Bool) -> Int {
        return isMaxIndex ? countMax : countMin
    }
    
    func isEmpty(isMaxIndex:Bool) -> Bool {
        return isMaxIndex ? countMax == 0 : countMin == 0
    }
    
    //对于传入的用户而言，是从0索引的
    func insert(i:Int, item:T) {
        var i = i
        guard (countMax + 1 < capacity) && (countMin + 1 < capacity) else {
            return
        }
        
        guard i + 1 >= 1 && i + 1 <= capacity else {
            return
        }
        
        i += 1
        data[i] = item
        indexesMax[countMax + 1] = i
        reverseMax[i] = countMax + 1
        
        countMax += 1
        
        indexesMin[countMin + 1] = i
        reverseMin[i] = countMin + 1
        
        countMin += 1
        
        shiftUpMax(k: countMax)
        shiftUpMin(k: countMin)
    }
    
    func extractMax() -> T? {
        guard countMax > 0 else {
            return nil
        }
        
        let ret = data[indexesMax[1]]
        indexesMax.swapAt(1, countMax)
        reverseMax[indexesMax[countMax]] = 0 //移除最大的，整体少了一个所以归0
        reverseMax[indexesMax[1]] = 1
        countMax -= 1
        shiftDownMax(k: 1)
        return ret
    }
    
    func extractMin() -> T? {
        guard countMin > 0 else {
            return nil
        }
        
        let ret = data[indexesMin[1]]
        indexesMin.swapAt(1, countMin)
        reverseMin[indexesMin[countMin]] = 0 //移除最大的，整体少了一个所以归0
        reverseMin[indexesMin[1]] = 1
        countMin -= 1
        shiftDownMin(k: 1)
        return ret
    }
    
    
    //与上面方法雷同，上面给的是数据，此方法给的是索引
    func extractMaxIndex() -> Int {
        guard countMax > 0 else {
            return 0
        }
        
        let ret = indexesMax[1] - 1 //对于外部，索引从0开始，所以减1
        indexesMax.swapAt(1, countMax)
        reverseMax[indexesMax[countMax]] = 0 //移除最大的，整体少了一个所以归0
        reverseMax[indexesMax[1]] = 1
        countMax -= 1
        shiftDownMax(k: 1)
        return ret
    }
    
    func extractMinIndex() -> Int {
        guard countMin > 0 else {
            return 0
        }
        
        let ret = indexesMin[1] - 1 //对于外部，索引从0开始，所以减1
        indexesMin.swapAt(1, countMin)
        reverseMin[indexesMin[countMin]] = 0 //移除最大的，整体少了一个所以归0
        reverseMin[indexesMin[1]] = 1
        countMin -= 1
        shiftDownMin(k: 1)
        return ret
    }
    
    func getMax() -> T? {
        guard countMax > 0 else {
            return nil
        }
        
        return data[indexesMax[1]]
    }
    
    func getMin() -> T? {
        guard countMin > 0 else {
            return nil
        }
        
        return data[indexesMin[1]]
    }
    
    func getMaxIndex() -> Int {
        guard countMax > 0 else {
            return 0
        }
        return indexesMax[1] - 1
    }
    
    func getMinIndex() -> Int {
        guard countMin > 0 else {
            return 0
        }
        return indexesMin[1] - 1
    }
    
    func containInMaxIndex(i:Int) -> Bool {
        guard i + 1 >= 1 && i + 1 <= capacity else {
            return false
        }
        
        return reverseMax[i + 1] != 0
    }
    
    func containInMinIndex(i:Int) -> Bool {
        guard i + 1 >= 1 && i + 1 <= capacity else {
            return false
        }
        
        return reverseMin[i + 1] != 0
    }
    
    func getItemInMaxIndex(i:Int) -> T? {
        guard containInMaxIndex(i: i) else {
            return nil
        }
        
        return data[i + 1]
    }
    
    func getItemInMinIndex(i:Int) -> T? {
        guard containInMinIndex(i: i) else {
            return nil
        }
        
        return data[i + 1]
    }
    
    func changeInMaxIndex(i:Int, newItem:T) {
        guard containInMaxIndex(i: i) else {
            return
        }
        
        var i = i
        i += 1
        data[i] = newItem
        
        let j = reverseMax[i]
        shiftUpMax(k: j)
        shiftDownMax(k: j)
    }
    
    func changeInMinIndex(i:Int, newItem:T) {
        guard containInMinIndex(i: i) else {
            return
        }
        
        var i = i
        i += 1
        data[i] = newItem
        
        let j = reverseMin[i]
        shiftUpMin(k: j)
        shiftDownMin(k: j)
    }
    
    //自动以完全二叉堆的格式打印：
    func testPrint(inMaxIndex:Bool) -> () {
        
        guard inMaxIndex ? countMax > 0 : countMin > 0 else {
            return
        }
        
        //打印堆结构，首先，过滤0位置，从1开始，前面加空格，为logN个，
        
        let lines = Int(round((log2(Double(inMaxIndex ? countMax : countMin))))) //先求出共多少行:5
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
            let tailNum = (i == lines ? (pow(2, lines) as NSDecimalNumber).intValue - 1 - (inMaxIndex ? countMax : countMin): 0)
            
            for k in 0..<needNum - tailNum {
                let item =  (data[(inMaxIndex ? indexesMax[k + needNum] : indexesMin[k + needNum])] as? Int)!
                str.append(String(format: "%.2d", item) + lastSpaceStr) //15,7,3,1
            }
            
            print(str)
            print("")
            
            printLines -= 1
        }
        
    }
    
}

//var indexHeapArr = randomArr(count: 64, rangeL: 0, rangeR: 99)
//var indexMaxHeap = IndexMaxHeap<Int>(capacity: indexHeapArr.count)
//
//for i in 0..<indexHeapArr.count {
//    indexMaxHeap.insert(i: i, item: indexHeapArr[i])
//}
//indexMaxHeap.testPrint(inMaxIndex: true)
//print("\n\n\n")
//indexMaxHeap.testPrint(inMaxIndex: false)

//三叉堆和D叉堆。动态capacity扩容，增加2倍
