//
//  ContentView.swift
//  GuessTheFlag_SwiftUI
//
//  Created by Vlad Furtuna on 25.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var streakCount = 0
    @State private var scoreMessage = ""
    @State private var scoreCount = 0
    
    @State private var gameCount = 0
    @State private var gameOverAlert = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.semibold))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.bold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                if streakCount > 0 {
                    Text("🔥 Streak: \(streakCount)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                }
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game over!", isPresented: $gameOverAlert) {
            Button("Start again", action: newGame)
        } message: {
            Text("Your final score is \(scoreCount) out of 8!")
        }
    }
    
    func flagTapped(_ number: Int) {
        gameCount += 1
        if gameCount == 8 {
            gameOverAlert = true
        }
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            streakCount += 1
            scoreCount += 1
            scoreMessage = "Keep going!"
        } else {
            scoreTitle = "Wrong"
            streakCount = 0
            scoreMessage = "That's the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
    func newGame() {
        gameCount = 0
        scoreCount = 0
        streakCount = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
