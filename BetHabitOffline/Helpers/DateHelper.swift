//
//  DateHelper.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/9.
//

import Foundation

func calcDaysDiff(_ start: Date, _ end: Date) -> Int {
    let calendar: Calendar = Calendar.current
    let startDate: Date = calendar.startOfDay(for: start)
    let endDate: Date = calendar.startOfDay(for: end)
    let res = calendar.dateComponents([.day], from: startDate, to: endDate)
    return res.day! + 1
}

// Returns the complete rate in percentage
func calcCompleteRate(_ passed: Int, _ total: Int) -> Int {
    var rate: Float = Float(passed) / Float(total)
    rate = rate * 100
    return Int((rate.rounded()))
}

func calcCompleteRate(_ passed: Int, _ total: Int) -> Float {
    return Float(passed) / Float(total)
}
