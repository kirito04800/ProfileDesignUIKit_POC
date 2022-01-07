//
//  Modifiable.swift
//  ProfileDesignUIKit_POC
//
//  Created by Kirito04800 on 07/01/2022.
//

protocol Modifiable {}

extension Modifiable where Self: Any {
    func withModifiers(_ block: (inout Self) -> ()) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension Modifiable where Self: AnyObject {
    @discardableResult
    func applyModifiers(_ block: (Self) -> ()) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Modifiable {}
