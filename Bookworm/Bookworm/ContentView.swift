//
//  ContentView.swift
//  Bookworm
//
//  Created by Glenn Gijsberts on 19/01/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.rating, order: .reverse),
        SortDescriptor(\.title)
    ]) var books: FetchedResults<Book>
    
    @State private var showAddBookView = false
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]
            
            // delete it from the context
            moc.delete(book)
        }
        
        // save the context
        try? moc.save()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack(spacing: 10) {
                            EmojiReviewView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown")
                                    .fontWeight(.bold)
                                    .foregroundColor(book.rating < 2 ? .red : .primary)
                                Text(book.author ?? "Unknown")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            showAddBookView.toggle()
                        }) {
                            Label("Add a new book", systemImage: "doc")
                        }
                        
                        EditButton()
                    } label: {
                        Label("Options", systemImage: "ellipsis.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddBookView) {
                AddBookView()
            }
            .navigationTitle("My books")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
