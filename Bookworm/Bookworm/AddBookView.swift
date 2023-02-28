//
//  AddBookView.swift
//  Bookworm
//
//  Created by Glenn Gijsberts on 21/01/2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var review = ""
    @State private var rating = 1
    @State private var genre = "Fantasy"
    @State private var author = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Romance", "Poetry", "Thriller"]
    
    var isValidForm: Bool {
        if (title.isEmpty || review.isEmpty || author.isEmpty) {
            return false
        }
        
        return true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                
                Section {
                    TextField("What did you think of this book?", text: $review, axis: .vertical)
                        .lineLimit(5)
                    
                    
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre
                        newBook.review = review
                        newBook.rating = Int16(rating)
                        newBook.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }.disabled(!isValidForm)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark")
                    }
                }
            }
            .navigationTitle("Add new book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
