//
//  ContentView.swift
//  Mathematics
//
//  Created by Glenn Gijsberts on 22/12/2022.
//

import SwiftUI

struct MainView: View {
  @State private var showQuestionsSheet = false
  @State private var table = 2
  @State private var amountOfQuestions = 1
  @State private var questions = [(number: Int, answer: Int)]()
  
  func reset() {
    questions = []
  }
  
  func handleStart() {
    for number in 1...amountOfQuestions {
      questions.append((number: number, answer: table * number))
    }
    
    showQuestionsSheet.toggle()
  }
  
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        Title("Learn tables")
      }
      .padding(.vertical, 24)
      
      VStack(alignment: .leading, spacing: 32) {
        StepperSection(label: "Which table do you want to play?", value: $table, range: 2...20)
        
        Divider()
        
        StepperSection(label: "How many questions do you want to get?", value: $amountOfQuestions, range: 1...10)
      }
      
      Spacer()
      
      CustomButton("Start", action: handleStart)
        .padding(.bottom, 16)
        .sheet(isPresented: $showQuestionsSheet, onDismiss: {
          reset()
          table = 2
          amountOfQuestions = 1
        }) {
          Sheet(questions: $questions, table: $table).presentationDragIndicator(.visible)
        }
    }
    .padding(.horizontal, 32)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
