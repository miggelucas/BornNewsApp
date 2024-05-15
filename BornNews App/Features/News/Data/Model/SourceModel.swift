//
//  SourceModel.swift
//  BornNews App
//
//  Created by Lucas Migge on 14/05/24.
//

import Foundation

struct SourceModel: Codable {
    let id: String?
    let name: String
    
    init(id: String? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
