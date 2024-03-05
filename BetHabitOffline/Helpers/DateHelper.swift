//
//  DateHelper.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/9.
//

import Foundation

// Extension for Date to make it RawRepresentable and can be saved into AppStorage
extension Date: RawRepresentable {
    public typealias RawValue = String
    public init?(rawValue: RawValue) {
        guard let data = rawValue.data(using: .utf8),
              let date = try? JSONDecoder().decode(Date.self, from: data) else {
            return nil
        }
        self = date
    }

    public var rawValue: RawValue{
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data:data,encoding: .utf8) else {
            return ""
        }
       return result
    }
}

func getTodayString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, d MMM y"
    return dateFormatter.string(from: Date.now).uppercased()
}

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

// TODO: check logic
func getDateInfoString(_ passedDays: Int, _ totalDays: Int) -> String {
    let remainingDays = totalDays - passedDays
    return String(format: "Day %d of %d, %d days remaining", arguments: [passedDays, totalDays, remainingDays])
}

func getDateInfoString(_ habit: Habit) -> String {
    let remainingDays = habit.totalDays - habit.passedDays
    return String(format: "Day %d of %d, %d days remaining", arguments: [habit.passedDays, habit.totalDays, remainingDays])
}
