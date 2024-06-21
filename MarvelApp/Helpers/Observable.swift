//
//  Observable.swift
//  MarvelApp
//
//  Created by Rafis on 21.06.2024.
//

import Foundation

final class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
