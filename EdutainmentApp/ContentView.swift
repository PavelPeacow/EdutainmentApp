//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Павел Кай on 16.05.2022.
//

import SwiftUI

enum StateOfGame {
    case preparing
    case playing
}

struct ContentView: View {
    @State private var amountQuestions = 10
    @State private var multiplyTables = 6
    
    @State private var stateGame = StateOfGame.preparing
    
    @State private var playerScore = 0
    @State private var round = 0
    
    @State private var finalMessage = ""
    @State private var isShowingFinal = false
    
    @State var firstDigit = 0
    
    @State var secondDigit = Int.random(in: 2...9)
    
    var correctAnswer: Int {
        return firstDigit * secondDigit
    }
    
    
    var wrongAnswers: [Int] = [4,6,8,10,12,14,16,18,
                               6,9,12,15,18,21,24,27,
                               8,12,16,20,24,28,32,36,
                               10,15,20,25,30,35,40,45,
                               12,18,24,30,36,42,48,54,
                               14,21,28,35,42,49,56,63,
                               16,24,32,40,48,56,64,72,
                               18,27,36,45,54,63,72,81]
    
    var arrayRightWrong: [Int] {
        return [correctAnswer, wrongAnswers.shuffled().randomElement()!]
    }
    
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [
                .init(color: .yellow, location: 0.3),
                .init(color: .orange, location: 0.2),
            ], center: .topLeading, startRadius: 410, endRadius: 850)
            .ignoresSafeArea()
            
            VStack {
                if stateGame == .preparing {
                    VStack {
                        Text("How much questions you want?")
                            .padding()
                        Stepper("Quantity of questions - \(amountQuestions)", value: $amountQuestions, in: 5...15, step: 5)
                    }
                    
                    VStack {
                        Text("Which multiplictaions tables \n you want to practice?")
                        Stepper("from 2 to \(multiplyTables)", value: $multiplyTables, in: 2...9, step: 1)
                    }
                    
                    Button("Start the game") {
                        firstDigit = Int.random(in: 2...multiplyTables)
                        stateGame = .playing
                    }
                }
                
                
                Spacer()
                if stateGame == .playing {
                    VStack {
                        Text("player score is \(playerScore)")
                        
                        Text("what is \(firstDigit) x \(secondDigit)?")
                    }
                    
                    Spacer()
                    
                    HStack {
                        ForEach(0..<2) { number in
                            Button {
                                isRightAnswer(number: number)
                            } label: {
                                Text("\(arrayRightWrong[number])")
                            }
                        }
                    }
                }

            }
        }
        .alert("Final score is \(playerScore)", isPresented: $isShowingFinal) {
            Button("Ok", action: reset)
        }
    }
    
    
    func isRightAnswer(number: Int) {
        if arrayRightWrong[number] == correctAnswer {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        
        endRound()
    }
    
    func endRound() {
        if round == amountQuestions - 1 {
            isShowingFinal = true
        } else {
            round += 1
            firstDigit = Int.random(in: 2...multiplyTables)
            secondDigit = Int.random(in: 2...9)
        }
    }
    
    func reset() {
        playerScore = 0
        round = 0
        firstDigit = Int.random(in: 2...multiplyTables)
        secondDigit = Int.random(in: 2...9)
        stateGame = .preparing
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
