// Created by Ina Statkic in 2021. 
// Copyright © 2021 Ina. All rights reserved.

import Foundation

struct Action: Identifiable, Equatable, Codable {
    var id: UUID
    var title: String
    
    init(title: String, id: UUID = UUID()) {
        self.title = title
        self.id = id
    }
}
