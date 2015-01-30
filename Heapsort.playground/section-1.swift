// Playground - noun: a place where people can play

import UIKit

var sort:[Int] = [1,0,10,20,3,5,6,4,9,8,12,17,34,11]

func maxHeapify(inout data:[Int], heapSize:Int, index:Int){
    
    var left = getChildLeftIndex(index)
    var right = getChildRightIndex(index)
    
    var largest = index
    
    if left < heapSize && data[left] > data[largest] {
        
        largest = left
        
    }
    
    if right < heapSize && data[right] > data[largest] {
    
        largest = right
        
    }
    
    
    if largest != index {
    
        var temp:Int = data[index]
        data[index] = data[largest]
        data[largest] = temp
        
        maxHeapify(&data, heapSize, largest)
    
    }
    

}

func getChildLeftIndex(currentIndex:Int)->Int{

    return (currentIndex << 1) + 1

}

func getChildRightIndex(currentIndex:Int)->Int{
    
    return (currentIndex << 1) + 2
    
}

func buildMaxHeap(inout data:[Int]){
    
    var i = (data.count/2)
    
    for i = (data.count/2); i >= 0; i-- {
        
        print(1)
    
        maxHeapify(&data, data.count, i)
        
        println(data)
    
    }
    
}



func heapsort(inout data:[Int]){
    
    var i = 0
    
    for i = data.count - 1; i>0; i-- {
        
        print(1)
        
        var temp = data[0]
        data[0] = data[i]
        data[i] = temp
        
        maxHeapify(&data, i, 0)
        
    }

}

buildMaxHeap(&sort)

println(sort)

heapsort(&sort)

println(sort)










