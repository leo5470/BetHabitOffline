//
//  DetailedHabitView.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/9.
//

import SwiftUI

struct DetailedHabitView: View {
    let habit: Habit
    
    @Environment(\.modelContext) var model
    
    @Binding var path: NavigationPath
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: LocalizedStringKey = ""
    
    init(habit: Habit, path: Binding<NavigationPath>) { // for test purposes
        self.habit = habit
        self._path = path
        print(habit.id)
    }
    
    var body: some View {
        let daysString: String = getDateInfoString(habit)
        
        ZStack {
            LinearGradient(colors: [.orange.opacity(0.7), .white], startPoint: .bottom, endPoint: .center)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack() {
                        Text("Habit")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        Spacer()
                        if(habit.dailyChecked){
                            HStack(alignment: .center, spacing: 4) {
                                Text("✅")
                                Text("Checked")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color(red: 0.05, green: 0.68, blue: 0))
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .frame(width: 124, alignment: .center)
                            .background(Color(red: 0.23, green: 1, blue: 0.04).opacity(0.15))
                            .cornerRadius(40)
                        } else {
                            Button(action: {
                                showAlert = true
                                alertTitle = "Check in?"
                            }) {
                                HStack(alignment: .center, spacing: 4) {
                                    Text("❌")
                                    Text("Not Checked")
                                        .font(.system(size: 15))
                                        .foregroundStyle(Color(red: 1, green: 0.04, blue: 0.04))
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 7)
                                .frame(width: 150, alignment: .center)
                                .background(Color(red: 1, green: 0.04, blue: 0.04).opacity(0.15))
                            .cornerRadius(40)
                            }
                            .alert(alertTitle, isPresented: $showAlert) {
                                Button("No", role: .cancel) {
                                    // Not supposed to do anything
                                }
                                Button("Yes") { // TODO: check-in animation
                                    habit.dailyChecked = true
                                    habit.passedDays += 1
                                    path = NavigationPath()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text(habit.name)
                            .font(.system(size: 32))
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                        Text(daysString)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.55))
                        HStack {
                            Text("You")
                                .font(.system(size: 24))
                                .foregroundStyle(.black)
                            Spacer()
                            Image("UserIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        
                        Text("v.s.")
                            .font(.system(size: 24))
                            .foregroundStyle(.black)
                            .padding(.vertical, 20)
                            .frame(height: 24)
                        
                        ForEach(0..<habit.peopleNum, id: \.self) { i in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(habit.peopleInfo[i].name)
                                        .font(.system(size: 24))
                                        .foregroundStyle(.black)
                                    Text(habit.peopleInfo[i].bet)
                                        .font(.system(size: 14))
                                        .fontWeight(.light)
                                        .foregroundStyle(.black.opacity(0.55))
                                }
                                Spacer()
                                Image("UserIcon")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }                    
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 500)
                    .background(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .inset(by: 0.5)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2)
                            .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 0)
                    )
                    .padding(.horizontal, 20.0)
                    
                    Spacer()
                        .frame(height: 15)
                    
                    HStack {
                        Button(action: {
                            showAlert = true
                            alertTitle = "Are you sure you're giving up?"
                        }){
                            Text("Give Up")
                                .foregroundStyle(.white)
                        }
//                        .frame(width: 175, height: 50)
                        .frame(width: 350, height: 50)
                        .background(.red)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                        .alert(alertTitle, isPresented: $showAlert){
                            Button("No", role: .cancel) {
                                // Not supposed to do anything
                            }
                            Button("Yes", role: .destructive) { // TODO: failed animation
                                model.delete(habit)
                                path = NavigationPath()
                            }
                        }
            
//                        TODO: Share function
//                        Spacer()
                        
//                        Button(action: {}){
//                            Text("Share")
//                                .foregroundStyle(.white)
//                        }
//                        .frame(width: 175, height: 50)
//                        .background(.accent)
//                        .clipShape(
//                            RoundedRectangle(cornerRadius: 12)
//                        )
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 20)
                    .padding(.top, 80)
                }
                .navigationBarTitleDisplayMode(.inline)
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
}

struct DetailedHabitView_Preview: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()
        NavigationStack(path: $path){
            DetailedHabitView(habit: getDummyHabit(true), path: $path)
        }

    }
}

#Preview {
    DetailedHabitView_Preview() as! any View
}
