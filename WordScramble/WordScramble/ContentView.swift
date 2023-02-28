//
//  ContentView.swift
//  WordScramble
//
//  Created by Glenn Gijsberts on 11/12/2022.
//

import SwiftUI

struct SectionLabel: ViewModifier {
  func body(content: Content) -> some View {
    content.textCase(.none)
  }
}

extension Text {
  func sectionLabel() -> some View {
    modifier(SectionLabel())
  }
}

struct InfoSheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
      NavigationStack {
        VStack(alignment: .leading, spacing: 16) {
          Text("Wordscramble is a word game in which players are given a set of 8 letters and must use those letters to make as many words as possible. Each letter can only be used once, so players must carefully rearrange the letters to form words.")
          
          Text("This game is great for improving vocabulary, spelling, and problem-solving skills. It can be played by people of all ages and is sure to provide hours of entertainment.")
          
          Spacer()
        }
          .padding(16)
          .navigationTitle("About WordScramble")
          .toolbar {
            Button("Close") {
              dismiss()
            }.foregroundColor(.indigo)
          }
      }
    }
}

struct ContentView: View {
  @State private var allWords: [String] = []
  @State private var usedWords: [String] = []
  @State private var rootWord = ""
  @State private var newWord = ""
  
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showError = false
  
  @State private var showInfoSheet = false
  
  @State private var score = 0
  
  func startApp() {
    if let startwordsUrl = Bundle.main.url(forResource: "start", withExtension: ".txt") {
      if let startWords = try? String(contentsOf: startwordsUrl) {
        allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement()!
        
        return
      }
    }
    
    fatalError("Start failed. WordScramble wasn't able to load properly.")
  }
  
  func addNewWord() {
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    
    guard answer.count > 2  else {
      handleError(title: "Not long enough..", message: "You need to make a word with at least 3 letters")
      
      return
    }
    
    guard answer != rootWord else {
      handleError(title: "Copycat..", message: "You don't get points for using the root word")
      
      return
    }
    
    guard isOriginal(word: answer) else {
      handleError(title: "Not original..", message: "You've already entered that word")
      
      return
    }
    
    guard isPossible(word: answer) else {
      handleError(title: "Not possible..", message: "You've entered a word that's not possible with this root word")
      
      return
    }
    
    guard isReal(word: answer) else {
      handleError(title: "Not real..", message: "You've entered a word that's not a real word")
      
      return
    }
    
    
    withAnimation {
      usedWords.insert(answer, at: 0)
    }
    
    score += answer.count
    newWord = ""
  }
  
  func isOriginal(word: String) -> Bool {
    !usedWords.contains(word)
  }
  
  func isPossible(word: String) -> Bool {
    var tempWord = rootWord
    
    for letter in word {
      if let foundLetterIndex = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: foundLetterIndex)
      } else {
        return false
      }
    }
    
    return true
  }
  
  func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
  }
  
  func handleError(title: String, message: String) {
    newWord = ""
    alertTitle = title
    alertMessage = message
    showError = true
  }
  
  func resetGame() {
    score = 0
    newWord = ""
    usedWords = []
    rootWord = allWords.randomElement()!
  }
  
  
  var body: some View {
    NavigationStack {
      List {
        Section(content: {
          TextField("Enter your word", text: $newWord).onSubmit {
            addNewWord()
          }
          .textInputAutocapitalization(.never)
        }, header: {
            Text("What can you make out of \(rootWord)?").sectionLabel()
          })
        
        Section(content: {
          if usedWords.count == 0 {
            Text("You didn't add a word yet..").foregroundColor(.gray)
          }
          
          ForEach(usedWords, id: \.self) { word in
            HStack {
              Image(systemName: "\(word.count).circle").foregroundColor(word.count > 4 ? .green : .orange)
              Text(word)
            }
          }
          
          if usedWords.count > 0 {
            Text("Your score is \(score)").foregroundColor(.gray)
          }
        }, header: {
          Text("Score").sectionLabel()
        })
        
        Section(content: {
          // Add modal view
          Button(action: {
            showInfoSheet.toggle()
          }, label: {
            Text("How does this work?").foregroundColor(.indigo)
          })
        }, header: {
          Text("More info").sectionLabel()
        })
          .sheet(isPresented: $showInfoSheet) {
            InfoSheetView()
          }
      }
      .toolbar {
        Button("New game") {
          resetGame()
        }
      }
      .accentColor(.indigo)
      .toolbarColorScheme(.dark, for: .navigationBar)
      .toolbarBackground(Color.indigo, for: .navigationBar)
      .navigationTitle(rootWord)
      .onAppear(perform: startApp)
      .alert(alertTitle, isPresented: $showError, actions: {
        Button("OK", role: .cancel) {}
      }, message: {
        Text(alertMessage)
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
