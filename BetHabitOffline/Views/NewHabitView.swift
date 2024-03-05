//
//  NewHabitView.swift
//  BetHabitOffline
//
//  Created by Leo Cheng on 2024/1/29.
//

import SwiftUI

struct NewHabitView: View {
    @Binding var path: NavigationPath
    
    @State private var habitName: String = ""
    @State private var deadline: Date = Date()
    @State private var peopleNum: Int = 1
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text("Make Your Habit")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                Text("Get started right away.")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black.opacity(0.55))
                
                Spacer()
                    .frame(height: 20)
                
                Text("How do you wanna call it?")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                TextField("Your habit name here", text: $habitName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                
                Text("What's the due date?")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                DatePicker("Due date", selection: $deadline, in: Date()..., displayedComponents: [.date])
                    .labelsHidden()
                
                Text("How many people are betting?")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Picker("Number of people betting here", selection: $peopleNum) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // TODO: make NavigationDestination usable since it is more efficient
            NavigationLink(value: HabitPrototype(name: habitName, deadline: deadline, peopleNum: peopleNum)) {
                Text("Next")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.accent)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 40)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewHabitView_Preview: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()
        NavigationStack(path: $path){
            NewHabitView(path: $path)
        }

    }
}

#Preview {
    NewHabitView_Preview() as! any View
}

