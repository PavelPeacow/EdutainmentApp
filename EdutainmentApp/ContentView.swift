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
    //Settings
    @State private var amountQuestions = 10
    @State private var multiplyTables = 6
    @State private var difficultyRange = 1
    
    //Game State
    @State private var stateGame = StateOfGame.preparing
    
    //Score
    @State private var playerScore = 0
    @State private var round = 0
    
    //Alert
    @State private var finalMessage = ""
    @State private var isShowingFinal = false
    
    //Left Right Digits
    @State private var firstDigit = 0
    @State private var secondDigit = Int.random(in: 2...9)
    
    private var correctAnswer: Int {
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
    
    @State private var arrayRightWrong: [Int] = []
    
    //Animation
    @State private var animationAmount = 0.0
    @State private var correctAnimation = false
    @State private var wrongAnimation = false
    
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
                            .font(.headline)
                        Stepper("Quantity of questions  \(amountQuestions)", value: $amountQuestions, in: 5...20, step: 5)
                            .padding()
                    }
                    
                    VStack {
                        Text("Which multiplictaions tables \n you want to practice?")
                            .padding()
                            .font(.headline)
                        Stepper("From 2 to \(multiplyTables)", value: $multiplyTables, in: 2...9, step: 1)
                            .padding()
                        
                    }
                    
                    VStack {
                        Text("Pick the difficulty")
                            .padding()
                            .font(.headline)
                        Picker("difficulty", selection: $difficultyRange) {
                            ForEach(0..<3) { level in
                                switch level {
                                case 0:
                                    Text("Easy")
                                case 1:
                                    Text("Medium")
                                case 2:
                                    Text("Hard")
                                default:
                                    Text("")
                                }
                            }
                        }
                    }
                    
                    Button("Start the game") {
                        firstDigit = Int.random(in: 2...multiplyTables)
                        questionsButtons()
                        withAnimation {
                            stateGame = .playing
                        }
                        
                    }
                    .padding(.top, 20)
                    
                }
                
                Spacer()
                
                if stateGame == .playing {
                    VStack {
                        Text("player score is \(playerScore)")
                            .font(.largeTitle)
                        Spacer()
                        Text("what is \(firstDigit) x \(secondDigit)?")
                            .font(.largeTitle)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        Spacer()
                        HStack {
                            ForEach(0..<difficultyRange + 2, id: \.self) { number in
                                Button {
                                    isRightAnswer(number: number)
                                } label: {
                                    Text("\(arrayRightWrong[number])")
                                        .padding(30)
                                        .background(.green)
                                        .clipShape(Circle())
                                        .foregroundColor(.yellow)
                                        .rotation3DEffect(
                                            .degrees(correctAnimation && correctAnswer == arrayRightWrong[number] ? 360 : 0)
                                            , axis: (x: 0, y: 1, z: 0))
                                }
                            }
                        }
                        Spacer()
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
            
            withAnimation {
                correctAnimation.toggle()
            }
        } else {
            if playerScore == 0 {

            } else {
                playerScore -= 1
            }
            
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
            
            questionsButtons()
            
            withAnimation {
                arrayRightWrong = arrayRightWrong.shuffled()
            }
        }
    }
    
    func reset() {
        playerScore = 0
        round = 0
        
        firstDigit = Int.random(in: 2...multiplyTables)
        secondDigit = Int.random(in: 2...9)
        
        withAnimation {
            stateGame = .preparing
        }
    }
    
    func questionsButtons() {
        switch difficultyRange {
        case 0: arrayRightWrong = [correctAnswer,
                                   wrongAnswers.shuffled().randomElement()!,
        ]
        case 1: arrayRightWrong = [correctAnswer,
                                   wrongAnswers.shuffled().randomElement()!,
                                   wrongAnswers.shuffled().randomElement()!,
        ]
        case 2: arrayRightWrong = [correctAnswer,
                                   wrongAnswers.shuffled().randomElement()!,
                                   wrongAnswers.shuffled().randomElement()!,
                                   wrongAnswers.shuffled().randomElement()!
        ]
        default:
            arrayRightWrong = [correctAnswer,
                               wrongAnswers.shuffled().randomElement()!,
                               wrongAnswers.shuffled().randomElement()!,
                               wrongAnswers.shuffled().randomElement()!
            ]
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
