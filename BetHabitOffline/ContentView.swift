//
//  ContentView.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/8.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(getTodayString())
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.55))
                        
                        Text("Today")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "list.bullet.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.accent)
                }
                .padding([.leading, .trailing], 20.0)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                
                HStack {
                    Text("Not Checked")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 20.0)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                // TODO: Import actual data
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(getDummyHabitArray()) {
                            habit in HabitCardView(habit: habit)
                        }
                    }
                    .frame(height: 225)
                }
                .padding([.leading, .trailing], 15)
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Text("Checked")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    .foregroundStyle(.black)
                }
                .padding([.leading, .trailing], 20.0)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                // TODO: Import actual data
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(getDummyHabitArray()) {
                            habit in HabitCardView(habit: habit)
                        }
                    }
                    .frame(height: 225)
                }
                .padding([.leading, .trailing], 15)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
