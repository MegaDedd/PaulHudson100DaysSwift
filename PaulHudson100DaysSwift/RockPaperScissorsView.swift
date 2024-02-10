//
//  RockPaperScissorsView.swift
//  PaulHudson100DaysSwift
//
//  Created by Константин on 10.02.2024.
//

import SwiftUI

struct RockPaperScissorsView: View {
    
    @State private var compChoise = Int.random(in: 0..<3)
    @State private var playerChoise: Int = -1
    
    @State private var winOrLose = Bool.random()
    @State private var isShowingScore = false
    
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var currentRound = 1
    @State private var isShowGameOver: Bool = false
    
    
    
    @State private var variants = ["Rock", "Paper", "Scissor"].shuffled()
    var variants2 = [1, 2, 0] // Papper, Scissor, Rock

    
    var body: some View {
        VStack(alignment: .leading, spacing: 100) {
            
            HStack {
                Text("\(winOrLose ? " Что может победить:" : "Чему проиграет:")")
                Text("\(variants[compChoise])")
            }
                        
            HStack(spacing: 100) {
                ForEach(0..<3, id: \.self) { item in
                    Button(action: {
                      choiseTapped(num: item)
                    }, label: {
                        Text(variants[item])
                    })
                   
                }
            }
            
                Text("Раунд: \(currentRound)\nОчки: \(score)")
        }
        .padding(.horizontal)
        .alert(scoreTitle, isPresented: $isShowingScore) {
            Button(action: {
                askQuestion()
            }, label: {
                Text("Вернуться")
            })
        }
        .alert("Конец игры", isPresented: $isShowGameOver) {
            Button(action: {
                
            }, label: {
                Text("Конец игры!")
            })
        }
        
    }

    func resultChoise(num: Int) -> String {
                
        if playerChoise == compChoise { return "Ничья" }
        var didWin: Bool
        
        if winOrLose {
            didWin = playerChoise == variants2[compChoise]
        } else {
            didWin = playerChoise == variants2[compChoise]
        }
                
        return didWin ? "Да" : "Нет"
    }
    
    func choiseTapped(num: Int) {
        playerChoise = num
        scoreTitle = resultChoise(num: playerChoise)
        
        if scoreTitle == "Ничья" {
                //
            } else if scoreTitle == "Да" {
                score += 1
            } else {
                score -= 1
            }
            if score < 0 {
                score = 0
            }

        isShowingScore = true
        winOrLose = Bool.random()
        compChoise = Int.random(in: 0...2)
    }
    func askQuestion() {
        if currentRound == 10 {
            isShowGameOver = true
            currentRound = 1
            score = 0
        } else {
            currentRound += 1
        }
    }
}

#Preview {
    RockPaperScissorsView()
}

