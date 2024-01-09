//
//  Item.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/8.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
