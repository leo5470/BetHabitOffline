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
    
    init() {
        self.name = ""
        self.bet = ""
    }
    
    init(name: String, bet: String) {
        self.name = name
        self.bet = bet
    }
}

struct HabitPrototype: Hashable {
    var name: String
    var deadline: Date
    var peopleNum: Int
}

@Model
class Habit : Identifiable, Hashable, ObservableObject {
    
    @Attribute(.unique) let id: String = UUID().uuidString
    var name: String
    var start: Date
    var deadline: Date
    var totalDays: Int
    var passedDays: Int
    var peopleNum: Int
    var peopleInfo: [Person]
    var dailyChecked: Bool
    var failed: Bool
    
    static func == (lhs: Habit, rhs: Habit) -> Bool { // Hashable conforms to Equatable
        return lhs.id == rhs.id // Since id is in UUID, the two ids must be unique
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Since id is in UUID, the two ids must be unique
    }
    
    init() {
        self.name = ""
        // Swift does not allow usage of var without completely initializing
        let now: Date = Date.now
        self.start = now
        self.deadline = now
        self.passedDays = 0
        self.peopleNum = 0
        self.peopleInfo = []
        self.dailyChecked = false
        self.totalDays = 0
        self.failed = false
    }
    
    init(habitPrototype: HabitPrototype) {
        self.name = habitPrototype.name
        // Swift does not allow usage of var without completely initializing
        let startCopy: Date = Date.now
        self.start = startCopy
        
        self.deadline = habitPrototype.deadline
        self.passedDays = 0
        self.peopleNum = habitPrototype.peopleNum
        self.peopleInfo = Array(repeating: Person(), count: habitPrototype.peopleNum)
        self.dailyChecked = false
        self.totalDays = calcDaysDiff(startCopy, habitPrototype.deadline)
        self.failed = false
    }
    
    init(name: String, deadline: Date, peopleNum: Int) {
        self.name = name
        // Swift does not allow usage of var without completely initializing
        let startCopy: Date = Date.now
        self.start = startCopy
        
        self.deadline = deadline
        self.passedDays = 0
        self.peopleNum = peopleNum
        self.peopleInfo = Array(repeating: Person(), count: peopleNum)
        self.dailyChecked = false
        self.totalDays = calcDaysDiff(startCopy, deadline)
        self.failed = false
    }
    
    init(name: String, deadline: Date, peopleNum: Int, peopleInfo: [Person]) {
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
        self.failed = false
    }
    
    init(name: String, start: Date, deadline: Date, peopleNum: Int, peopleInfo: [Person]) {
        self.name = name
        self.start = start
        
        self.deadline = deadline
        self.passedDays = 0
        self.peopleNum = peopleNum
        self.peopleInfo = peopleInfo
        self.dailyChecked = false
        
        self.totalDays = calcDaysDiff(start, deadline)
        self.failed = false
    }
    
    func copyFromPrototype(habitPrototype: HabitPrototype){
        name = habitPrototype.name
        deadline = habitPrototype.deadline
        peopleNum = habitPrototype.peopleNum
        peopleInfo = Array(repeating: Person(), count: peopleNum)
        totalDays = calcDaysDiff(start, deadline)
    }
}
