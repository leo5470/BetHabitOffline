//
//  HabitCardModel.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/8.
//

import Foundation

class HabitCard: Identifiable {
    var id: String
    var name: String
    var dailyChecked: Bool
    var completeRate: Int
    var totalDays: Int
    var passedDays: Int
    var remainingDays: Int

    init(_ habit: Habit){
        self.id = habit.id
        self.name = habit.name
        self.dailyChecked = habit.dailyChecked
        self.totalDays = habit.totalDays
        self.passedDays = habit.passedDays
        
        let rate: Float = Float(passedDays / totalDays)
        self.completeRate = Int((rate.rounded()) * 100)
        
        self.remainingDays = totalDays - passedDays

    }
}
