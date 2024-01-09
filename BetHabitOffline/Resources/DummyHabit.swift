//
//  DummyHabit.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/8.
//

import Foundation

func getDummyHabit() -> Habit {
    let dummyPeopleInfo: [Person] = [Person(
        name: "Bamboo",
        bet: "A cup of Long Island")]

    var dummyHabit: Habit = Habit(name: "Study hard",start: Date(timeIntervalSinceNow: -86400), deadline: Date(timeIntervalSinceNow: 432000), peopleNum: 1, peopleInfo: dummyPeopleInfo)
    dummyHabit.passedDays += 1
    
    return dummyHabit
}
