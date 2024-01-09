//
//  HabitModel.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/8.
//

import Foundation
import SwiftData

struct Person : Codable {
    var name: String
    var bet: String
}

//@Model
class Habit : Identifiable, ObservableObject {
    var id: String
    var name: String
    var start: Date
    var deadline: Date
    var totalDays: Int
    var passedDays: Int
    var peopleNum: Int
    var peopleInfo: [Person]
    var dailyChecked: Bool
    
    init(name: String, deadline: Date, peopleNum: Int, peopleInfo: [Person]) {
        self.id = UUID().uuidString
        self.name = name
        // Swift does not allow usage of var without completely initializing
        let startCopy: Date = Date.now
        self.start = startCopy
        
        self.deadline = deadline
        self.passedDays = 0
        self.peopleNum = peopleNum
        self.peopleInfo = peopleInfo
        self.dailyChecked = false
        
        self.totalDays = calcDaysDiff(startCopy, deadline)
    }
    
    init(name: String, start: Date, deadline: Date, peopleNum: Int, peopleInfo: [Person]) {
        self.id = UUID().uuidString
        self.name = name
        self.start = start
        
        self.deadline = deadline
        self.passedDays = 0
        self.peopleNum = peopleNum
        self.peopleInfo = peopleInfo
        self.dailyChecked = false
        
        self.totalDays = calcDaysDiff(start, deadline)
    }
}
