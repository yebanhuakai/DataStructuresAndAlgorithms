//
//  BinarySearchTree.swift
//  DataStructuresAndAlgorithms
//
//  Created by Shenry on 2017/10/7.
//  Copyright © 2017年 Shenry. All rights reserved.
//

import Foundation

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





