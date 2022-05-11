//
//  NSObject+Extensions.swift
//  ResumeApp
//
//  Created by Emre on 10.05.2022.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
