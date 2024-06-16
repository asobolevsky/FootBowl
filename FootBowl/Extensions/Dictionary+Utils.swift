//
//  Dictionary+Utils.swift
//  FootBowl
//
//  Created by Aleksei Sobolevskii on 2024-06-13.
//

import Foundation

extension Dictionary {
    var nilIfEmpty: [Key: Value]? {
        isEmpty ? nil : self
    }
}
