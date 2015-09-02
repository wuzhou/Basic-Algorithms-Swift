//: Alias Method

import UIKit

struct ProbTuple
{
    var probIndex:Int = 0
    var prob:Double = 0.0
}

struct AliasTuple
{
    var probIndex:Int = 0
    var prob:Double = 0.0
    var alias:Int = 0
    
}

func GenerateAliasTable(probs:[ProbTuple]) -> [AliasTuple]
{
    var aliasTable:[AliasTuple] = [AliasTuple]()
    
    var newProbs:[ProbTuple] = [ProbTuple]()
    
    for p in probs
    {
        var nProb:ProbTuple = ProbTuple()
        nProb.probIndex = p.probIndex
        nProb.prob = p.prob * Double(probs.count)
        
        newProbs.append(nProb)
    }
    
    while(newProbs.count > 1)
    {
        var pl:ProbTuple = ProbTuple()
        for var i:Int=0; i<newProbs.count; i++
        {
            let op = newProbs[i]
            
            if op.prob <= 1
            {
                pl = op
                newProbs.removeAtIndex(i)
                break
            }
        }
        
        var pg:ProbTuple = ProbTuple()
        for var i:Int=0; i<newProbs.count; i++
        {
            let op = newProbs[i]
            
            if op.prob >= 1
            {
                pg = op
                newProbs.removeAtIndex(i)
                break
            }
        }
        
        var aliasTuple = AliasTuple()
        aliasTuple.prob = pl.prob
        aliasTuple.probIndex = pl.probIndex
        aliasTuple.alias = pg.probIndex
        
        aliasTable.append(aliasTuple)
        
        var newP = ProbTuple()
        newP.probIndex = pg.probIndex
        newP.prob = pg.prob - ( 1.0 - pl.prob)
        
        newProbs.append(newP)
    }
    
    if let lastTuple = newProbs.last
    {
        var lastAlias = AliasTuple()
        lastAlias.probIndex = lastTuple.probIndex
        lastAlias.prob = 1.0
        lastAlias.alias = 0
        
        aliasTable.append(lastAlias)
    }
    
    return aliasTable
}

let probsTable = [ProbTuple(probIndex: 1, prob: 0.2), ProbTuple(probIndex: 2, prob: 0.3), ProbTuple(probIndex: 3, prob: 0.5)]

let aliasTable = GenerateAliasTable(probsTable)


for var i:Int=0; i<10; i++
{
    let index = Int(arc4random_uniform(UInt32(aliasTable.count)))
    
    let alias = aliasTable[index]
    
        let probValue = Double(arc4random()) / Double(UInt32.max)
        
        if probValue < alias.prob
        {
            println(alias.probIndex)
        }
        else
        {
            println(alias.alias)
        }
    
}