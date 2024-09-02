//
//  AddBookView.swift
//  Bookworm
//
//  Created by Andres Rivillas on 9/04/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 4
    @State private var genre = "fantasy"
    @State private var review = ""
    @State private var isBookValid: Bool = false
    
    let genres = ["Fantastic","Horror","Kids","Mystery","Poetry","Romance","Thriller"]
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date())
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
                .disabled(checkBookValid())
                .navigationTitle("Add Book")
                
            }
        }
    }
    
    func checkBookValid() -> Bool {
        if title.isWhitespace || author.isWhitespace || review.isWhitespace{
            return true
        }
        return false
    }
}

#Preview {
    AddBookView()
}
