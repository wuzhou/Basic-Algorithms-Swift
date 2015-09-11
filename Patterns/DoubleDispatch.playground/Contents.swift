//: Playground - noun: a place where people can play

import UIKit

//Elements

class Event
{
    func printName()
    {
        println("通用事件")
    }
    
    func recordEvent(recorder:EventRecorder)
    {
        recorder.recordEvent(self)
    }
}

class KeyEvent: Event
{
    override func printName()
    {
        println("按钮事件")
    }
    
    override func recordEvent(recorder: EventRecorder)
    {
        recorder.recordEvent(self)
    }
}


//Visitors

class EventRecorder
{
    func recordEvent(event: Event)
    {
        println("EventRecorder 记录通用事件")
    }
    
    func recordEvent(event: KeyEvent)
    {
        println("EventRecorder 记录按钮事件")
    }
    
}

class AdvanceEventRecorder: EventRecorder
{
    override func recordEvent(event: Event)
    {
        println("AdvanceRecoder 记录通用事件")
    }
    
    override func recordEvent(event: KeyEvent)
    {
        println("AdvanceRecoder 记录按钮事件")
    }
}

let recorder:EventRecorder = AdvanceEventRecorder()
let event:Event = KeyEvent()
recorder.recordEvent(event)
event.recordEvent(recorder)
