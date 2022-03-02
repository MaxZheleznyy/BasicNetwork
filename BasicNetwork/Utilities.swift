//
//  Utilities.swift
//  BasicNetwork
//
//  Created by MAXIM ZHELEZNYY on 01.03.2022.
//

import Foundation

public typealias VoidBlock = () -> Void
public typealias ResultBlock<T, E: Error> = (Result<T, E>) -> Void

@inlinable
public func redispatchToMainThread(_ block: @escaping VoidBlock) {
    if Thread.current.isMainThread {
        block()
        return
    }
    DispatchQueue.main.async {
        block()
    }
}
