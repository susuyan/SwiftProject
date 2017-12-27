//
//  ArrayExtensions.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/20.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

public func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

extension Array {
    
    ///EZSE: Get a sub array from range of index
    public func get(at range: ClosedRange<Int>) -> Array {
        let halfOpenClampedRange = Range(range).clamped(to: Range(indices))
        return Array(self[halfOpenClampedRange])
    }
    
    /// EZSE: Checks if array contains at least 1 item which type is same with given element's type
    public func containsType<T>(of element: T) -> Bool {
        let elementType = type(of: element)
        return contains { type(of: $0) == elementType}
    }
    
    /// EZSE: Decompose an array to a tuple with first element and the rest
    public func decompose() -> (head: Iterator.Element, tail: SubSequence)? {
        return (count > 0) ? (self[0], self[1..<count]) : nil
    }
    
    /// EZSE: Iterates on each element of the array with its index. (Index, Element)
    public func forEachEnumerated(_ body: @escaping (_ offset: Int, _ element: Element) -> Void) {
        enumerated().forEach(body)
    }
    
    /// EZSE: Gets the object at the specified index, if it exists.
    public func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
    /// EZSE: Prepends an object to the array.
    public mutating func insertFirst(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    /// EZSE: Returns a random element from the array.
    public func random() -> Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    
    /// EZSE: Reverse the given index. i.g.: reverseIndex(2) would be 2 to the last
    public func reverseIndex(_ index: Int) -> Int? {
        guard index >= 0 && index < count else { return nil }
        return Swift.max(count - 1 - index, 0)
    }

    
    /// EZSE: Returns an array with the given number as the max number of elements.
    public func takeMax(_ n: Int) -> Array {
        return Array(self[0..<Swift.max(0, Swift.min(n, count))])
    }
    
    /// EZSE: Checks if test returns true for all the elements in self
    public func testAll(_ body: @escaping (Element) -> Bool) -> Bool {
        return !contains { !body($0) }
    }
    
    /// EZSE: Checks if all elements in the array are true or false
    public func testAll(is condition: Bool) -> Bool {
        return testAll { ($0 as? Bool) ?? !condition == condition }
    }
}
