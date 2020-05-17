//
//  Repo.swift
//  Mogit
//
//  Created by Jan Provazník on 17/05/2020.
//  Copyright © 2020 Jan Provazník. All rights reserved.
//

import Foundation

typealias Codable = Encodable & Decodable

struct Repo: Codable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
