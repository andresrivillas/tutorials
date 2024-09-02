//
//  Book.swift
//  Bookworm
//
//  Created by Andres Rivillas on 9/04/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: Date?
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date?) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}

extension String {
    var isWhitespace: Bool {
        // Trim whitespace characters from both ends of the string
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check if the resulting string is empty
        return trimmedString.isEmpty
    }
}
