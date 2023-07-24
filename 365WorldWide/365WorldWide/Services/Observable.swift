//
//  Observable.swift
//  YourLacky
//
//  Created by MacBook on 10.07.2023.
//

import Foundation

final class Observable<T> {
    typealias Listener = (T) -> Void

    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
