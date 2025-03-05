//
//  Quote.swift
//  QuoteFinder
//
//  Created by Skye Willow Harris-Stoertz on 2025-03-03.
//

import Foundation

struct Quote: Codable {
    
    // MARK: Stored properties
    let quoteText: String
    let quoteAuthor: String?
}
 
// Create an example quote for testing purposes
let exampleQuote = Quote(
    quoteText: "The beginning of knowledge is the discovery of something we do not understand.",
    quoteAuthor: "Frank Herbert"

)
