//
//  DetailView.swift
//  Bookworm
//
//  Created by Glenn Gijsberts on 27/01/2023.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre == "" ? "Fantasy" : book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
                
                if book.author != nil {
                    VStack {
                        Text(book.author!.uppercased())
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(.black.opacity(0.75))
                            .clipShape(Capsule())
                            .offset(x: 5, y: -5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            if book.review != nil {
                VStack {
                    Text("Review")
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(book.review!)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
            if book.date != nil {
                VStack {
                    Text("Completed on")
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(book.date!, style: .date)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
