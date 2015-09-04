//FibonacciHeap

func ==(lhs: TreeNode, rhs: TreeNode) -> Bool
{
    return lhs.hashValue == rhs.hashValue
}

class TreeNode : Hashable
{
    var value:Int
    var parent:TreeNode?
    var children:Set<TreeNode>
    var marked:Bool
    
    init(initValue:Int)
    {
        value = initValue
        children = Set<TreeNode>()
        marked = false
    }
    
    var hashValue : Int
    {
        get
        {
            return value
        }
    }
    
    var rank : Int
    {
        get
        {
            return children.count
        }
    }
}

class FibonacciHeap
{
    
    var treeRoots:Set<TreeNode>
    var minRoot:TreeNode?
    
    init()
    {
        treeRoots = Set<TreeNode>()
    }
    
    func insert(value: Int)
    {
        let insertNode = TreeNode(initValue: value)
        treeRoots.insert(insertNode)
        
        if let node:TreeNode = minRoot
        {
            if(insertNode.value < node.value)
            {
                minRoot = insertNode
            }
        }
        else
        {
            minRoot = insertNode
        }
    }
    
    func minValue()->Int
    {
        var minValue = -1
        
        if let node:TreeNode = minRoot
        {
           minValue = node.value
        }
        
        return minValue
    }
    
    func deleteMin()
    {
        if let node:TreeNode = minRoot
        {
            let children = node.children
            
            treeRoots.remove(node)
            
            for childNode in children
            {
                treeRoots.insert(childNode)
            }
            
            updateMin()
            
            treeRoots = consolidateTrees(treeRoots)
            
        }
    }
    
    func updateMin()
    {
        if treeRoots.count > 0
        {
            minRoot = treeRoots.first
            
            for node in treeRoots
            {
                if(node.value < minRoot?.value)
                {
                    minRoot = node
                }
            }
        }
        else
        {
            minRoot = nil
        }
    }
    
    func consolidateTrees(roots:Set<TreeNode>)->Set<TreeNode>
    {
        var varRoots = roots
        var newRoots = Set<TreeNode>()
        
        var i:Int = 0
        
        var oneTree:TreeNode?
        var otherTree:TreeNode?
        
        outterLoop: for node in varRoots
        {
            var j:Int = 0
            for otherNode in varRoots
            {
                if j > i
                {
                    if node.rank == otherNode.rank
                    {
                        oneTree = node
                        otherTree = otherNode
                        
                        break outterLoop
                        
                    }
                }
                
                j++
            }
            
            i++
        }
        
        if (oneTree != nil) && (otherTree != nil)
        {
            varRoots.remove(otherTree!)
            varRoots.remove(oneTree!)
            
            if oneTree!.rank <= otherTree!.rank
            {
                otherTree!.parent = oneTree
                oneTree!.children.insert(otherTree!)
                newRoots.insert(oneTree!)
            }
            else
            {
                oneTree!.parent = otherTree
                otherTree!.children.insert(oneTree!)
                newRoots.insert(otherTree!)
            }
            
            for tree in varRoots
            {
                newRoots.insert(tree)
            }
            
            newRoots = consolidateTrees(newRoots)
            
        }
        else
        {
            for tree in varRoots
            {
                newRoots.insert(tree)
            }
            
        }
        
        return newRoots
    }
    
    func decreaseKey(var node:TreeNode, newKeyValue:Int)
    {
        if let var parent = node.parent
        {
             node.value = newKeyValue
            
            if  node.value <= parent.value
            {
                node.parent = nil
                node.marked = false
                treeRoots.insert(node)
                
                if(!parent.marked)
                {
                    parent.marked = true
                }
                else
                {
                    meldNodeRecuesive(parent)
                }
            }

        }
        else
        {
            node.value = newKeyValue
            updateMin()
        }
    }
    
    func meldNodeRecuesive(var node:TreeNode)
    {
        if let var parent = node.parent
        {
            node.parent = nil
            node.marked = false
            treeRoots.insert(node)
            
            if(parent.marked)
            {
                meldNodeRecuesive(parent)
            }
        }
    }
    
}

let heap = FibonacciHeap()
heap.insert(4)
heap.insert(3)
heap.deleteMin()
heap.insert(3)
heap.insert(1)
heap.deleteMin()
heap.insert(1)

println(heap.minValue())

var firstNode:TreeNode = heap.treeRoots.first!

heap.decreaseKey(firstNode, newKeyValue: 2)

firstNode = heap.treeRoots.first!

heap.deleteMin()

println(heap.minValue())

