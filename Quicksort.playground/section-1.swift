
import Foundation

var sort:[Int] = [1,0,10,20,3,5,6,4,9,8,12,17,34,11]

func partition(inout data:[Int], leftIndex:Int, rightIndex:Int)->Int{
    
    var index:Int = leftIndex

    let pivot:Int = data[leftIndex]
    
    swap(&data[index], &data[rightIndex])
    
    for var i:Int = leftIndex; i<rightIndex; i++ {
    
        if data[i] < pivot {
        
            swap(&data[i], &data[index++])
        
        }
        
    
    }
    
    swap(&data[rightIndex], &data[index])
    
    return index
    
}

func qsort(inout data:[Int], leftIndex:Int, rightIndex:Int){

    if leftIndex >= rightIndex {
        return
    }
    
    var index:Int = partition(&data, leftIndex, rightIndex)
    
    qsort(&data, leftIndex, index-1)
    qsort(&data, rightIndex+1, rightIndex)

}

qsort(&sort, 0, sort.count-1)


//Randomization

func randPartition(inout data:[Int], leftIndex:Int, rightIndex:Int)->Int{

    var index:Int = leftIndex;
    
    let randomIndex:Int = leftIndex + Int(arc4random_uniform(rightIndex - leftIndex + 1))
    
    let pivot:Int = data[randomIndex]
    
    swap(&data[randomIndex], &data[rightIndex])
    
    for var i:Int = leftIndex; i<rightIndex; i++ {
    
        if data[i] < pivot {
        
            swap(&data[i], &data[index++])
        
        }
        
    }
    
    swap(&data[rightIndex], &data[index])
    
    return index

}


func randQsort(inout data:[Int], leftIndex:Int, rightIndex:Int){

    if leftIndex >= rightIndex {
    
        return
        
    }
    
    var index:Int = randPartition(&data, leftIndex, rightIndex)
    
    randQsort(&data, leftIndex, index-1)
    randQsort(&data, index+1, rightIndex)

}

randQsort(&sort, 0, sort.count-1)