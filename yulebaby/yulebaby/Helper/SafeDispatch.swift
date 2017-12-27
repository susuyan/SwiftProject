//
//  SafeDispatch.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/19.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

public struct SafeDispatch {

    // MARK: - Dispatch
    
    /// EZSE: Runs the function after x seconds
    public static func dispatchDelay(_ second: Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(second * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    /// EZSE: Runs function after x seconds
    public static func runThisAfterDelay(seconds: Double, after: @escaping () -> Void) {
        runThisAfterDelay(seconds: seconds, queue: DispatchQueue.main, after: after)
    }
    
    //TODO: Make this easier
    /// EZSE: Runs function after x seconds with dispatch_queue, use this syntax: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
    public static func runThisAfterDelay(seconds: Double, queue: DispatchQueue, after: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
    
    /// EZSE: Submits a block for asynchronous execution on the main queue
    public static func runThisInMainThread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }

    
    /// EZSE: Runs in Default priority queue
    public static func runThisInBackground(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    /// EZSE: Runs every second, to cancel use: timer.invalidate()
    @discardableResult public static func runThisEvery(
        seconds: TimeInterval,
        startAfterSeconds: TimeInterval,
        handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = startAfterSeconds + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    /// EZSE: Gobal main queue
    @available(*, deprecated: 1.7, renamed: "DispatchQueue.main")
    public var globalMainQueue: DispatchQueue {
        return DispatchQueue.main
    }
    
    /// EZSE: Gobal queue with user interactive priority
    @available(*, deprecated: 1.7, renamed: "DispatchQueue.main")
    
    public var globalUserInteractiveQueue: DispatchQueue {
        return DispatchQueue.global(qos: .userInteractive)
    }
    
    /// EZSE: Gobal queue with user initiated priority
    @available(*, deprecated: 1.7, renamed: "DispatchQueue.global()")
    public var globalUserInitiatedQueue: DispatchQueue {
        return DispatchQueue.global(qos: .userInitiated)
    }
    
    /// EZSE: Gobal queue with utility priority
    @available(*, deprecated: 1.7, renamed: "DispatchQueue.global()")
    public var globalUtilityQueue: DispatchQueue {
        return DispatchQueue.global(qos: .utility)
    }
    
    /// EZSE: Gobal queue with background priority
    @available(*, deprecated: 1.7, renamed: "DispatchQueue.global()")
    public var globalBackgroundQueue: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }
    
    /// EZSE: Gobal queue with default priority
    @available(*, deprecated: 1.7, renamed: "DispatchQueue.global()")
    public var globalQueue: DispatchQueue {
        return DispatchQueue.global(qos: .default)
    }

}
