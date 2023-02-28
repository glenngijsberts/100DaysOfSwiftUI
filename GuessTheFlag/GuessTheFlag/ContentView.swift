//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Glenn Gijsberts on 27/11/2022.
//

import SwiftUI

struct FlagImage: View {
  let country: String
  
  init(_ country: String) {
      self.country = country
  }
  
  var body: some View {
    Image(country)
      .renderingMode(.original)
      .cornerRadius(12)
  }
}

struct ContentView: View {
  private let amountOfQuestions = 8
  
  @State private var flagTapped = 0
  @State private var showingAnswerResult = false
  @State private var scoreTitle = ""
  @State private var scoreText = ""
  @State private var score = 0
  @State private var questionsCount = 0
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  
  private var noQuestionsLeft: Bool {
    questionsCount == amountOfQuestions
  }
  
  private var currentFlag: String {
    countries[correctAnswer]
  }
  
  func handleTap(_ number: Int) {
    flagTapped = number
    
    if number == correctAnswer {
      scoreTitle = "Correct"
      score += 1
    } else {
      scoreTitle = "Wrong answer"
    }
    
    questionsCount += 1
    
    if noQuestionsLeft {
      scoreText = "Your answer was \(countries[number]) and total score is \(score)"
    } else {
      scoreText = "Your answer was \(countries[number])"
    }
    
    showingAnswerResult = true
  }
  
  func nextQuestion() {
    flagTapped = 0
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
  
  func resetGame() {
    scoreTitle = ""
    scoreText = ""
    score = 0
    questionsCount = 0
    
    nextQuestion()
  }
  
  var body: some View {
    ZStack {
      LinearGradient(colors: [Color.orange, Color.red], startPoint: .top, endPoint: .leading)
        .ignoresSafeArea()
      
      VStack(spacing: 48) {
        VStack(spacing: 8) {
          Text("Tap the flag of").foregroundColor(.white).font(.largeTitle)
          Text(currentFlag).foregroundColor(.white).font(.largeTitle.bold())
        }
        
        VStack(spacing: 32) {
          ForEach(0..<3) { number in
            Button {
              handleTap(number)
            } label: {
              FlagImage(countries[number])
            }
          }
        }
        
        Text("Score").foregroundColor(.white).font(.title2)
        Text("\(score) / \(amountOfQuestions)").foregroundColor(.white).font(.largeTitle.bold())
      }
      .alert(scoreTitle, isPresented: $showingAnswerResult) {
        Button("Continue", action: noQuestionsLeft ? resetGame : nextQuestion)
      } message: {
        Text(scoreText)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
