//
//  ContentView.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/8.
//

import SwiftUI
import SwiftData

// TODO: Figure out how to do navigation properly
struct ContentView: View {
    @Environment(\.modelContext) var model
    
    @Query(filter: #Predicate<Habit>{ habit in
        habit.dailyChecked == true && habit.failed == false
    }) private var checkedHabits: [Habit]
    
    @Query(filter: #Predicate<Habit>{ habit in
        habit.dailyChecked == false && habit.failed == false
    }) private var uncheckedHabits: [Habit]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                LinearGradient(colors: [.orange.opacity(0.7), .white], startPoint: .bottom, endPoint: .center)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(getTodayString())
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black.opacity(0.55))
                            
                            Text("Welcome back!")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }
                        
                        Spacer()
                        // TODO: Menu view
//                            Image(systemName: "list.bullet.circle.fill")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                                .foregroundStyle(.accent)
                        
                    }
                    .padding(.horizontal, 20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    if !checkedHabits.isEmpty || !uncheckedHabits.isEmpty { // TODO: change scenario
                        VStack {
                            HStack {
                                Text("Not Checked")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20.0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            if !uncheckedHabits.isEmpty {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(uncheckedHabits) {
                                            unchecked in
                                            NavigationLink(value: unchecked) {
                                                HabitCardView(habit: unchecked)
                                            }
                                        }
                                    }
                                    .frame(height: 225)
                                }
                            } else {
                                VStack(alignment: .leading) {
                                    Text("No undone habit, keep it up!")
                                        .font(.system(size: 20))
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 220)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .inset(by: 0.5)
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                                        .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 0)
                                )
                                .padding(.horizontal, 20)
                            }

                            
                            Spacer()
                                .frame(height: 20)
                            
                            HStack {
                                Text("Checked")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                            .padding(.horizontal, 20.0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            // TODO: Import actual data
                            if !checkedHabits.isEmpty {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(checkedHabits) { // TODO: change source
                                            checked in
                                            NavigationLink(value: checked) {
                                                HabitCardView(habit: checked)
                                            }
                                        }
                                    }
                                    .frame(height: 225)
                                }
                            } else {
                                VStack(alignment: .leading) {
                                    Text("No habit done, get it going!")
                                        .font(.system(size: 20))
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 220)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .inset(by: 0.5)
                                        .foregroundColor(.white)
                                        .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                                        .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 0)
                                )
                                .padding(.horizontal, 20)
                                
                                Spacer()
                            }
                        }
                    } else {
                        VStack {
                            Text("No ongoing habit.")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                            Text("Create a new one below!")
                        }
                            .padding(.horizontal, 20)
                            .frame(maxWidth: .infinity)
                            .frame(height: 500)
                            .background(
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .inset(by: 0.5)
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                                    .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 0)
                            )
                            .padding(.horizontal, 20.0)
                    }
                    
                    Spacer()
                    
                    NavigationLink(value: Route.newHabit) {
                        Text("New habit...")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.accent)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )
                        .padding(.horizontal, 20)
                    }
                    .navigationDestination(for: Habit.self) { // would not perfectly work if declared outside of VStack
                        habit in DetailedHabitView(habit: habit, path: $path)
                    }.navigationDestination(for: HabitPrototype.self) {
                        habitPrototype in NewHabitBetView(habitPrototype: habitPrototype, path: $path)
                    }.navigationDestination(for: Route.self) {
                        dest in switch dest {
                            case .newHabit:
                                NewHabitView(path: $path)
                        }
                    }
                }
                    .navigationTitle("Home")
                    .padding(.vertical, 20)
                }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self, inMemory: true)
}
