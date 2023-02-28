//
//  QuestionsSheet.swift
//  Mathematics
//
//  Created by Glenn Gijsberts on 22/12/2022.
//

import SwiftUI

enum Field: Hashable {
  case field
}

struct Sheet: View {
  @Environment(\.dismiss) var dismiss
  
  @State private var score = 0
  @State private var currentQuestion = 0
  @State private var answer = 0
  
  @State private var finished = false
  
  @Binding var questions: [(number: Int, answer: Int)]
  @Binding var table: Int
  
  @FocusState private var focusedField: Field?
  
  var isLastQuestion: Bool {
    questions.count - 1 == currentQuestion
  }
  
  var title: String {
    questions.count > 0 ? "What is \(table) x \(questions[currentQuestion].number)?" : "Let's play tables"
  }
  
  func handleAnswer() {
    let isCorrectAnswer = answer == questions[currentQuestion].answer
    
    if (isCorrectAnswer) {
      score += 1
    }
    
    if (isLastQuestion) {
      return finishTables()
    }
    
    handleNextQuestion()
  }
  
  func handleNextQuestion () {
    answer = 0
    currentQuestion += 1
  }
  
  func finishTables() {
    finished = true
    focusedField = nil
  }
  
  func handleClose() {
    dismiss()
  }
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        Title(title)
      }
      .padding(.vertical, 24)
      
      TextField("What is your answer?", value: $answer, format: .number).keyboardType(.numberPad).focused($focusedField, equals: .field)
        .font(.title)
        .textFieldStyle(.roundedBorder)
        .disabled(finished)
      
      Spacer()
      
      if finished {
        Text("Your final score is \(score)!").font(.headline).fontWeight(.heavy)
      }
      
      CustomButton(finished ? "Close" : isLastQuestion ? "Finish" : "Next question", action: finished ? handleClose : handleAnswer)
        .padding(.bottom, 16)
    }
    .padding(.horizontal, 32)
  }
}
