//
//  HabitCardView.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/8.
//

import SwiftUI

struct HabitCardView: View {
    let habit: Habit
    var body: some View {
        
        let remainingDays = habit.totalDays - habit.passedDays
        let daysString: String = String(format: "Day %d of %d, %d days remaining", arguments: [habit.passedDays, habit.totalDays, remainingDays])
        let completedRate: Int = calcCompleteRate(habit.passedDays, habit.totalDays)
        let completedString: String = String(format: "%d%% completed", arguments: [completedRate])
        
        VStack(alignment: .leading) {
            Text(habit.name)
                .font(.system(size: 32))
                .fontWeight(.medium)
                .foregroundStyle(.black)
            Text(daysString)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.55))
            Spacer()
                .frame(height: 10)
            Text(completedString)
                .font(.system(size: 36))
                .fontWeight(.medium)
                .foregroundStyle(.black)
            Spacer()
                .frame(height: 30)
            ProgressView(value: Float(completedRate) / 100)
                .tint(.accent)
                .padding(.trailing, 20.0)
        }
        .frame(width: 340, height: 220)
        .padding(/*@START_MENU_TOKEN@*/.leading, 20.0/*@END_MENU_TOKEN@*/)
        .background(
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .inset(by: 0.5)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 0)
        )
    }
}

#Preview {
    HabitCardView(habit: getDummyHabit())
}
