//
//  ContentView.swift
//  Bookworm
//
//  Created by Andres Rivillas on 9/04/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Book.title, order: .reverse),
                  SortDescriptor(\Book.author, order: .reverse)]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) {
                    book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .black)
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self){
                DetailView(book: $0)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book ", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offSet in  offsets {
            let book = books[offSet]
            modelContext.delete(book)
        }
    }
}



#Preview {
    ContentView()
}
