//
//  RadixSort.swift
//  Algorithm
//
//  Created by xingyajie on 2022/11/24.
//

import Foundation

class RadixSort: ArraySort {
    static func sort(arr: [Int]) -> [Int] {
        if arr.count < 2 { return arr }
        var list = arr
        
        radixSort(arr: &list)
        
        return list;
    }
    
    static func radixSort(arr: inout [Int]) {
        var max = arr[0];
        for i in 0..<arr.count {
            if arr[i] > max {
                max = arr[i]
            }
        }
        
        var outPuts = [Int].init(repeating: 0, count: arr.count)
        var counts = [Int].init(repeating: 0, count: 10);
        
        var divider = 1
        while divider <= max {
            
            countingSort(arr: &arr, divider: divider, output: &outPuts, count: &counts)
            divider *= 10
        }
    }
    
    static func countingSort(arr: inout [Int], divider: Int, output: inout [Int], count: inout [Int]) {
        for i in 0..<count.count {
            count[i] = 0
        }
        for i in 0..<arr.count {
            count[arr[i]/divider%10] += 1
        }
        for i in 1..<count.count {
            count[i] += count[i-1]
        }
        for i in (0..<arr.count).reversed() {
            count[arr[i]/divider%10] -= 1
            output[count[arr[i]/divider%10]] = arr[i]
        }
        for i in 0..<arr.count {
            arr[i] = output[i]
        }
    }
}

class RadixSort1: ArraySort {
    static func sort(arr: [Int]) -> [Int] {
        if arr.count < 2 { return arr }
        var list = arr
        
        radixSort(arr: &list)
        
        return list;
    }
    
    static func radixSort(arr: inout [Int]) {
        var max = arr[0];
        for i in 0..<arr.count {
            if arr[i] > max {
                max = arr[i]
            }
        }
        
        // 创建十个桶, 每个桶内可以存储最多arr.count个数据
        var buckets = [[Int]].init(repeating: [Int].init(repeating: 0, count: arr.count), count: 10)
        // 每个桶的元素数量
        var bucketSizes = [Int].init(repeating: 0, count: buckets.count)
        
        var divider = 1
        while divider <= max {
            
            for i in 0..<arr.count {
                let no = arr[i] / divider % 10
                buckets[no][bucketSizes[no]] = arr[i]
                bucketSizes[no] += 1
            }
            
            var index = 0
            for i in 0..<buckets.count {
                for j in 0..<bucketSizes[i] {
                    arr[index] = buckets[i][j]
                    index += 1
                }
                bucketSizes[i] = 0
            }
    
            divider *= 10
        }
    }

}
