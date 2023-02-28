//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Glenn Gijsberts on 04/12/2022.
//

import SwiftUI

struct LearnMoreSheet: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 16) {
        Text("Rock, Paper, Scissors is a simple game that requires two players. Each player selects either rock, paper or scissors. Rock beats scissors, scissors beats paper and paper beats rock. The player who chooses the winning object wins the game.")
          .fontWeight(.regular)
        
        Text("This time, you play versus the computer and you need to either win or lose from either rock, paper or scissors.")
          .fontWeight(.regular)
        
        Spacer()
      }
      .padding()
      .navigationTitle("Learn more")
      .toolbar {
        Button("Close") {
          dismiss()
        }
      }
    }
  }
}

struct Option {
  let option: String
  let defeats: String
  
  init(_ option: String, _ defeats: String) {
    self.option = option
    self.defeats = defeats
  }
}

struct ContentView: View {
  @State private var showingLearnMoreSheet = false
  
  @State private var needsToWin = Bool.random()
  @State private var optionThatYouNeedtoDefeat = Int.random(in: 0...2)
  
  @State private var score = 0
  @State private var questionsLeft = 2
  
  @State private var showAlert = false
  @State private var title = ""
  @State private var message = ""
  
  let options = [Option("✊", "✌️"), Option("✌️", "🤚"), Option("🤚", "✊")]
  
  var option: String {
    options[optionThatYouNeedtoDefeat].option
  }
  
  func handleAnswer(_ answer: Option) {
    if (needsToWin && answer.defeats == option || !needsToWin && answer.defeats != option && answer.option != option) {
      score += 1
      title = "Correct!"
    } else {
      title = "Incorrect!"
    }
    
    message = "Your answer was \(answer.option)"
    
    handleNextQuestion()
  }
  
  func checkAnswer(_ input: String) {
    let answer = options[options.firstIndex(where: { $0.option == input } )!]
    
    handleAnswer(answer)
  }
  
  func handleOptions() {
    needsToWin = Bool.random()
    optionThatYouNeedtoDefeat = Int.random(in: 0...2)
  }
  
  func handleRestart() {
    score = 0
    questionsLeft = 2
    
    handleOptions()
  }
  
  func handleNextQuestion() {
    if (questionsLeft == 0) {
      title = "You completed the challenge!"
      message = "Your score is \(score)"
      
      handleRestart()
    } else {
      questionsLeft -= 1
      handleOptions()
    }
    
    
    showAlert = true
  }
  
  var body: some View {
    ZStack {
      Color.blue
        .ignoresSafeArea()
      
      VStack(spacing: 64) {
        VStack(spacing: 32) {
          Text("Let's play a game of..")
            .foregroundColor(.white)
            .fontWeight(.medium)
          
          Text("✊ 🤚 ✌️")
            .font(.largeTitle)
        }.padding(.top, 16)
        
        Spacer()
        
        VStack(spacing: 32) {
          HStack(spacing: 32) {
            ForEach(options.map({
              $0.option
            }), id: \.self) { option in
              Button(action: {
                checkAnswer(option)
              }) {
                Text(option)
                  .font(.system(size: 64))
              }
            }
          }
          
          Text("You need to \(needsToWin ? "win" : "lose") from \(option)")
            .font(.title)
            .foregroundColor(.white)
            .fontWeight(.semibold)
        }
        
        Spacer()
        
        Text("Your score is \(score)")
          .foregroundColor(.white)
        
        Button(action: {
          showingLearnMoreSheet.toggle()
        }) {
          Text("Learn more")
            .font(.headline)
            .frame(maxWidth: .infinity)
        }
        .tint(.white)
        .buttonStyle(.bordered)
        .controlSize(.large)
        .padding()
        .alert(isPresented: $showAlert) {
          Alert(
            title: Text(title),
            message: Text(message)
          )
        }
        .sheet(isPresented: $showingLearnMoreSheet) {
          LearnMoreSheet()
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
