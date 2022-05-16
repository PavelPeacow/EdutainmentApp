//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Павел Кай on 16.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var amountQuestions = 10
    @State private var multiplyTables = 6
    @State private var isStarted = false
    
    @State private var questionTable2 = ["2 x 2", "2 x 3", "2 x 4", "2 x 5",
                                    "2 x 6", "2 x 7", "2 x 8", "2 x 9"]
    
    @State private var questionTable3 = ["3 x 2", "3 x 3", "3 x 4", "3 x 5",
                                    "3 x 6", "3 x 7", "3 x 8", "3 x 9"]
    
    @State private var questionTable4 = ["4 x 2", "4 x 3", "4 x 4", "4 x 5",
                                    "4 x 6", "4 x 7", "4 x 8", "4 x 9"]
    
    @State private var questionTable5 = ["5 x 2", "5 x 3", "5 x 4", "5 x 5",
                                    "5 x 6", "5 x 7", "5 x 8", "5 x 9"]
    
    @State private var questionTable6 = ["6 x 2", "6 x 3", "6 x 4", "6 x 5",
                                    "6 x 6", "6 x 7", "6 x 8", "6 x 9"]
    
    @State private var questionTable7 = ["7 x 2", "7 x 3", "7 x 4", "7 x 5",
                                    "7 x 6", "7 x 7", "7 x 8", "7 x 9"]
    
    @State private var questionTable8 = ["8 x 2", "8 x 3", "8 x 4", "8 x 5",
                                    "8 x 6", "8 x 7", "8 x 8", "8 x 9"]
    
    @State private var questionTable9 = ["9 x 2", "9 x 3", "9 x 4", "9 x 5",
                                    "9 x 6", "9 x 7", "9 x 8", "9 x 9"]
                                   
    
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [
                .init(color: .yellow, location: 0.3),
                .init(color: .orange, location: 0.2),
            ], center: .topLeading, startRadius: 410, endRadius: 850)
            .ignoresSafeArea()
            
            
            VStack {
                Text("How much questions you want?")
                    .padding()
                Stepper("Quantity of questions - \(amountQuestions)", value: $amountQuestions, in: 5...15, step: 5)
                
                Text("Which multiplictaions tables \n you want to practice?")
                Stepper("from 2 to \(multiplyTables)", value: $multiplyTables, in: 2...9, step: 1)
                
                Button("Start the game") {}
                
                if isStarted == false {
                    Text("")
                }
                
                
                Spacer()
                
                HStack {
                    Button("First button") {
                        
                    }
                    .padding()
                    .background(.green)
                    .clipShape(Capsule())
                    
                    Button("Second button") {
                        
                    }
                    .padding()
                    .background(.green)
                    .clipShape(Capsule())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
