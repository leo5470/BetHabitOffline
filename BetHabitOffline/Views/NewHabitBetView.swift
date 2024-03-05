//
//  NewHabitBetView.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/30.
//

import SwiftUI
import SwiftData

struct NewHabitBetView: View {
    var habitPrototype: HabitPrototype
    
    @Environment(\.modelContext) var model
    
    @Binding var path: NavigationPath
    
    @State private var habit: Habit
    
    init(habitPrototype: HabitPrototype, path: Binding<NavigationPath>) {
        print(habitPrototype.hashValue)
        self.habitPrototype = habitPrototype
        _path = path
        _habit = State(initialValue: Habit(habitPrototype: habitPrototype))
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
                    Text("Make Your Habit")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    .foregroundStyle(.black)
                    
                    Text("Get started right away.")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black.opacity(0.55))
                }
                
                Spacer()
                    .frame(height: 20)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(0..<habitPrototype.peopleNum, id: \.self) { num in // \.self avoids reading initially and never updating afterwards
                            Text("Person \(num + 1)")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            TextField("Name", text: $habit.peopleInfo[num].name)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.vertical, 0)
                            
                            Text("What's the bet?")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            TextField("Bet", text: $habit.peopleInfo[num].bet)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.vertical, 0)

                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 20)
        }
            
            Spacer()
            
            Button(action: { // TODO: backend - save habit
                model.insert(habit)
                path = NavigationPath()
            }){
                Text("Make habit!")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.accent)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 40)
            .navigationBarTitleDisplayMode(.inline)
        }
}

struct NewHabitBetView_Preview: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()
        NavigationStack(path: $path){
            NewHabitBetView(habitPrototype: HabitPrototype(name: "Study hard", deadline: Date.now, peopleNum: 4), path: $path)
        }
    }
}


#Preview {
    NewHabitBetView_Preview() as! any View
}
