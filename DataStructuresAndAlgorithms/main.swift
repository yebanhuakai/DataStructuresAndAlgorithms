//
//  main.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/9/29.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

//------------------------------♨️---------------------------------//



//------------------------------♨️---------------------------------//

// MARK: - 插入排序：如果后面的比前面的小，就把大于后面的全部后移，最后将其拿到前面
func insertionSort<T:Comparable>(arr:inout [T]) {
    
    for i in 1..<arr.count { //注意从1开始
        let e = arr[i] //需要检查的元素
        
        var j = i
        
        while j >= 1 && arr[j - 1] > e {
            arr[j] = arr[j - 1]
            j -= 1
        }
        
        arr[j] = e
    }
    
}

func insertionSort2<T:Comparable>(arr:inout [T]) {
    
    for i in 1..<arr.count { //注意从1开始
        let e = arr[i] //需要检查的元素

        var index = i //注意，此处外面不可以定义j，里面的j与外面的j系统会认为是两个
        for j in (1...i).reversed() where arr[j - 1] > e { //j-1是0，所以必须从1开始.提前终止内存循环是插入排序非常重要的性质
            
            arr[j] = arr[j - 1]
            index = j - 1 //记录最后一个比e大的索引，就是需要赋值到e的索引
        }
        
        arr[index] = e
    }
}

//var insertArr = randomArr(count: 100, rangeL: 0, rangeR: 10) //插入排序对于范围小、连续度高的数组排序比选择更快
//var arrCP1 = insertArr
//var arrCP2 = insertArr
//
//timeClac(fn: selectionSort(arr:), arr: &arrCP1, funcName: "SelectionSort") //注意函数类型调用方法
//timeClac(fn: insertionSort(arr:), arr: &arrCP1, funcName: "insertionSort1")
//print(arrCP1[0...99])
//timeClac(fn: insertionSort2(arr:), arr: &arrCP2, funcName: "insertionSort2")
//print(arrCP2[0...99])


//var newArr = randomNearlyOrderArr(count: count100_000, swapTimes: 10)
//var newArr1 = newArr
//var newArr2 = newArr
//
//timeClac(fn: selectionSort(arr:), arr: &newArr1, funcName: "SelectionSort") //注意函数类型调用方法
//timeClac(fn: insertionSort(arr:), arr: &newArr2, funcName: "InsertionSort") //连续度高的数组插入更快，因为能提前终止循环
//insertArr.sorted(by: <)

//Bubble Sort ⭐️作业
//Shell Sort ⭐️作业

//------------------------------♨️---------------------------------//

// MARK: - 归并排序，不断分成片段排序，最后组合
func mergeSort<T:Comparable>(arr:inout [T]) {
    __mergeSort(arr: &arr, l:0, r:arr.count - 1) //索引位置
    //    __mergeSortBU(arr: &arr, l: 0, r: arr.count - 1)
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

//递归使用归并排序，自顶向下
func __mergeSort<T:Comparable>(arr:inout [T], l:Int, r:Int) { //[1,4,3,2]
    
    guard l < r else {
        return
    }
    
//    if r - l <= 15 {
//        insertionSort(arr: &arr)
//        return
//    }
    
    let mid = (l + r) / 2 //未防止溢出
    
    __mergeSort(arr: &arr, l: l, r: mid) //0, 1
    __mergeSort(arr: &arr, l: mid + 1, r: r) // 2,3
    if arr[mid] > arr[mid+1] { //如果小于等于，说明已经排好了
        __merge(arr: &arr, l: l, mid: mid, r: r)
    }
}

//将arr[l...mid]和arr[mid+1...r]两部分进行归并
func __merge<T:Comparable>(arr:inout [T], l:Int, mid:Int, r:Int) {
    
    //开始排序及合并
    //1.需要开辟额外的空间
    var aux = Array(repeatElement(arr[0], count: r - l + 1))
    for i in l...r {
        aux[i-l] = arr[i]
    }
    
    var i = l, j = mid + 1
    for k in l...r {
        
        if i > mid {
            arr[k] = aux[j-l]
            j += 1
        } else if j > r {
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

//var mergeArr = randomArr(count: 10000, rangeL: 0, rangeR: 10)
//var mergeArr = randomNearlyOrderArr(count: 15, swapTimes: 7)
//var mergeArr1 = mergeArr
//var mergeArr2 = mergeArr
//print(mergeArr[0...100])
//timeClac(fn: insertionSort(arr:), arr: &mergeArr1, funcName: "⚠️InsertionSort")
//print(mergeArr1[0...14])
//timeClac(fn: mergeSort(arr:), arr: &mergeArr2, funcName: "⚠️MergeSort ")
//print(mergeArr2[0...14])

//------------------------------♨️---------------------------------//

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

//var quick3Arr = randomNearlyOrderArr(count: count1_000_000, swapTimes: 10)
//var quick3Arr1 = quick3Arr
//var quick3Arr2 = quick3Arr
//var quick3Arr3 = quick3Arr
//
//timeClac(fn: quickSort(arr:), arr: &quick3Arr1, funcName: "QuickSort ")
//print(quick3Arr1[0...49])
//timeClac(fn: quickSort3Way(arr:), arr: &quick3Arr2, funcName: "Quick3Sort ")
//print(quick3Arr2[0...49])
//timeClac(fn: mergeSort(arr:), arr: &quick3Arr3, funcName: "MergeSort ")
//print(quick3Arr3[0...49])

//逆序对 ⭐️作业 （归并算法）
//第n大元素 ⭐️作业 （快速排序算法）

//------------------------------♨️---------------------------------//

//heap sort 堆
class MaxHeap<T:Comparable> {
    
    var count = 0
    var data:[T]!
    
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
//let n = 16 //最大129，否则无法显示
//var heapArr = randomArr(count: count1_000_000, rangeL: 0, rangeR: count1_000_000)
//var heapArr1 = heapArr
//var heapArr2 = heapArr
//var heapArr3 = heapArr

//for i in (1...n - 1).reversed() {
//    maxHeap.insert(item: i)
//}

//for _ in 1..<n {
//    maxHeap.insert(item: Int(arc4random() % 100))
//}

//maxHeap.testPrint()
//while !maxHeap.isEmpty() {
//    print(maxHeap.shiftDown())
//}

//timeClac(fn: heapSort2(arr:), arr: &heapArr1, funcName: "HeapSort2") //heapify过程O(n)级别,但需额外空间
//print(heapArr1[0...49])
//
//timeClac(fn: quickSort3Way(arr:), arr: &heapArr2, funcName: "Quick3Sort")
//print(heapArr2[0...49])
//
//timeClac(fn: heapSort(arr:), arr: &heapArr3, funcName: "HeapSort") //数组本地操作
//print(heapArr3[0...49])

//------------------------------♨️---------------------------------//
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

//------------------------------♨️---------------------------------//
// MARK: - Binary Search 二分查找法O(n)，必须是有序数组
func binarySearch<T:Comparable>(arr:[T], n:Int, target:T) -> Int {
    
    var l = 0, r = n - 1
    while l <= r {
        let mid = l + (r - l) / 2
        
        if arr[mid] == target {
            return mid
        }
        
        if target < arr[mid] {
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

//var binarySearchArr = randomArr(count: 64, rangeL: 0, rangeR: 64)
//quickSort3Way(arr: &binarySearchArr)
//print(binarySearchArr)
//let target = binarySearch(arr: binarySearchArr, n: binarySearchArr.count, target: 55)
//print("Target is :", target)
//let targetRe = binarySearchRecursion(arr: binarySearchArr, l: 0, r: binarySearchArr.count - 1, target: 55)
//print("Recursion Target is :", targetRe)

// MARK: - 二分搜索树，
// TODO: - floor， ceil， rank， select ，支持重复元素
// FIXME:
class BST<Key:Comparable, Value>{
    
     class Node {
        var key:Key
        var value:Value
        var left:Node?
        var right:Node?
        
        init(key:Key, value:Value) {
            self.key = key
            self.value = value
            self.left = nil
            self.right = nil
        }
        
        init(node:Node) {
            self.key = node.key
            self.value = node.value
            self.left = node.left
            self.right = node.right
        }
    }
    
    var root:Node!
    var count:Int = 0
    
    func size() -> Int {
        return count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func insert(key:Key, value:Value) {
        root = insert(node: root, key: key, value: value)
    }
    
    func contain(key:Key) -> Bool {
        return contain(node: root, key: key)
    }
    
    func search(key:Key) -> Value? {
        return search(node: root, key: key)
    }
    
    //前序遍历
    func preOrder() {
        preOrder(node: root)
    }
    
    //中序遍历
    func inOrder() {
        inOrder(node: root)
    }
    
    //后序遍历
    func postOrder() {
        postOrder(node: root)
    }
    
    //层序遍历，利用队列
    func levelOrder() {
        let q = Queue()
        q.enqueue(object: root!)
        
        while !q.isEmpty() {
            let node = q.dequeue() as! Node
            print("node key: \(node.key) value: \(node.value)")
            
            if (node.left != nil) {
                q.enqueue(object: node.left!)
            }
            
            if (node.right != nil) {
                q.enqueue(object: node.right!)
            }
        }
        
    }
    
    func minimum() -> Key? {
        guard count != 0 else {
            return nil
        }
        
        let minNode = minimum(node: root)
        return minNode?.key
    }
    
    func maximum() -> Key? {
        guard count != 0 else {
            return nil
        }
        
        let minNode = maximum(node: root)
        return minNode?.key
    }
    
    func removeMin() {
        if root != nil {
            var new = root //将隐式可选型转为可选型
            root = removeMin(node: &new)
        }
    }
    
    func removeMax() {
        if root != nil {
            var new = root
            root = removeMax(node: &new)
        }
    }
    
    func remove(key:Key) {
        var new = root
        root = remove(node: &new, key: key)
    }
    
    //向以node为根的二叉搜索树中，插入节点（key，value）
    //返回插入新节点后的二叉搜索树的根
    private func insert(node:Node?, key:Key, value:Value) -> Node {
        if node == nil {
            count += 1
            return Node(key: key, value: value)
        }
        
        //如果key已经存在，更新值
        if node!.key == key {
            node!.value = value
        } else if key < node!.key {
            node!.left = insert(node: node!.left, key: key, value: value)
        } else {
            node!.right = insert(node: node!.right, key: key, value: value)
        }
        
        return node!
    }
    
    private func contain(node:Node?, key:Key) -> Bool {
        guard node != nil else {
            return false
        }
        
        if key == node!.key {
            return true
        } else if key < node!.key {
            return contain(node: node!.left, key: key)
        } else {
            return contain(node: node!.right, key: key)
        }
    }
    
    private func search(node:Node?, key:Key) -> Value? {
        guard node != nil else {
            return nil
        }
        
        if key == node!.key {
            return node!.value
        } else if key < node!.key {
            return search(node: node!.left, key: key)
        } else {
            return search(node: node!.right, key: key)
        }

    }
    
    private func preOrder(node:Node?) {
        if node != nil {
            print("node key: \(node!.key) value: \(node!.value)")
            preOrder(node: node!.left)
            preOrder(node: node!.right)
        }
    }
    
    private func inOrder(node:Node?) {
        if node != nil {
            inOrder(node: node!.left)
            print("node key: \(node!.key) value: \(node!.value)")
            inOrder(node: node!.right)
        }
    }
    
    private func postOrder(node:Node?) {
        if node != nil {
            postOrder(node: node!.left)
            postOrder(node: node!.right)
            print("node key: \(node!.key) value: \(node!.value)")
        }
    }

    private func destroy(node:inout Node?) {
        if node != nil {
            destroy(node: &node!.left)
            destroy(node: &node!.right)
            node = nil
            count -= 1
        }
    }
    
    //以node为根的二叉树中，返回最小点
    private func minimum(node:Node?) -> Node? {
        if node?.left == nil {
            return node
        }
        
        return minimum(node: node?.left)
    }
    
    private func maximum(node:Node?) -> Node? {
        if node?.right == nil {
            return node
        }
        
        return maximum(node: node?.right)
    }
    
    //删除最小节点，递归判断是否有左节点，没有删除，且把右节点赋值给自己的父节点的左孩子
    private func removeMin(node:inout Node?) -> Node? {
        
        guard node != nil else {
            return nil
        }
        
        if node!.left == nil {
            
            let rightNode = node?.right
            node = nil
            count -= 1
            return rightNode
        }
        
        node!.left = removeMin(node: &node!.left)
        return node
    }
    
    private func removeMax(node:inout Node?) -> Node? {
        
        guard node != nil else {
            return nil
        }
        
        if node!.right == nil {
            
            let rightNode = node?.left
            node = nil
            count -= 1
            return rightNode
        }
        
        node!.right = removeMax(node: &node!.right)
        return node
    }

    //⭐️删除以node为根键值为key的节点，
    private func remove(node:inout Node?, key:Key) -> Node? {
        guard node != nil else {
            return nil
        }
        
        if key < node!.key {
            return remove(node: &node!.left, key: key)
        } else if key > node!.key {
            return remove(node: &node!.right, key: key)
        } else {
            //关键在于删除此节点后，其子节点如何拼接，因为新的节点可以是右结点的最小节点也可以是左节点的最大节点，这里用前者
            //先考虑没有左子节点，及既没有左节点也没有右节点, 则直接返回右节点或nil
            if node!.left == nil {
                let rightNode = node!.right
                node = nil
                count -= 1
                return rightNode
            }
            
            //如果没有右节点，就直接返回左节点
            if node!.right == nil {
                let leftNode = node!.left
                node = nil
                count -= 1
                return leftNode
            }
            
            //如果既有左节点又有右节点， 则取右节点的最小子节点或左节点最大子节点，这里用前者
            let successor = minimum(node: node!.right)
            //同时删除该右侧最小节点
            successor?.right = removeMin(node: &node!.right)
            successor?.left = node?.left
            
            node = nil
            count -= 1
            
            return successor
        }
    }
    
    func printStruction() {
        
    }
    
//floor， ceil， rank， select ，支持重复元素
    
}

let bst = BST<Int,Int>()

let testBSTArr = [28, 16, 30, 13, 22, 29, 42]

for i in testBSTArr {
    let node = BST<Int, Int>.Node(key: i, value: i)
    bst.insert(key: node.key, value: node.value)
}
//
//bst.preOrder()
//print("\n")
//bst.inOrder()
//print("\n")
//bst.postOrder()
//print("\n")
//bst.levelOrder()

//------------------------------♨️---------------------------------//
// MARK: - Union Find 并查集
class UnionFind {
    var parent:[Int]
    var rank:[Int]
    var count = 0
    
    init(count:Int) {
        parent = [Int](sequence(first: 0, next: { $0 < count-1 ? $0 + 1 : nil }))
        rank = [Int](repeatElement(1, count: count))
        self.count = count
    }
    
    func size() -> Int {
        return count
    }
    
    func isConnected(p:Int, q:Int) -> Bool {
        return findRoot(p) == findRoot(q)
    }
    
    func findRoot(_ p:Int) -> Int {
        guard p >= 0 && p < count else {
            return -1
        }
        
        //如果p的父结点是自己，则一定是根，停止循环并返还，否则递归遍历到根并赋值回来
        if p !=  parent[p] {
            parent[p] = findRoot(parent[p])
        }
        return parent[p]
    }
    
    func union(p:Int, q:Int) {
        let pRoot = findRoot(p)
        let qRoot = findRoot(q)
        
        if pRoot == qRoot {
            return
        }
        
        if rank[pRoot] < rank[qRoot] {
            parent[pRoot] = qRoot
        } else if rank[pRoot] > rank[qRoot]{
            parent[qRoot] = pRoot
        } else {
            parent[pRoot] = qRoot
            rank[qRoot] += 1 //被设为根的rank+1
        }
    }
    
}

let uf = UnionFind(count: count1_000_000)

let timeStart = Date()

for _ in 0..<count1_000_000 {
    let a = Int(arc4random()) % count1_000_000
    let b = Int(arc4random()) % count1_000_000
    uf.union(p: a, q: b)
}

for _ in 0..<count1_000_000 {
    let a = Int(arc4random()) % count1_000_000
    let b = Int(arc4random()) % count1_000_000
    uf.isConnected(p: a, q: b)
}

let timeEnd = Date()
let seconds = timeEnd.timeIntervalSince(timeStart)
print("Union Find Eclipse time: ", seconds)

//------------------------------♨️---------------------------------//
// MARK: - 图论 Graph Theory



