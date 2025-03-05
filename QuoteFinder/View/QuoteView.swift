//
//  ContentView.swift
//  QuoteFinder
//
//  Created by Skye Willow Harris-Stoertz on 2025-03-03.
//

import SwiftUI

struct QuoteView: View {
    
    // MARK: Stored properties
    
    // Create the view model (temporarily show the default quote)
    @State var viewModel = QuoteViewModel()
    
    // Controls author visibility
    @State var quoteAuthorOpacity = 0.0
    
    // Controls button visibility
    @State var buttonOpacity = 0.0
    
    // Starts a timer to wait on revealing author
    @State var quoteAuthorTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // Starts a timer to wait on revealing button to get new joke
    @State var buttonTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    
    // MARK: Computed properties
    var body: some View {
        VStack {
            
            Rectangle()
                .fill(Color.cyan)
                .stroke(.blue, lineWidth: 10)
                .frame(width: .infinity, height: 200)
                .overlay(alignment: .center) {
                    Text("Quote")
                    .foregroundStyle(.gray)
                    .font(.system(size: 50.0, weight: .bold, design: .default))
                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 0))
                    Text("Quote")
                    .foregroundStyle(.white)
                    .font(.system(size: 50.0, weight: .bold, design: .default))
                }
            
            Image(systemName: "books.vertical")
                .foregroundStyle(.gray)
                .font(.system(size: 40))
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                    
            Spacer()
            
            // Show a quote if one exists
            if let currentQuote = viewModel.currentQuote {
                
                Group {
                    Text(currentQuote.quoteText ?? "")
                        .padding(.init(top: 0, leading: 12, bottom: 100, trailing: 12))
                    
                    Text(currentQuote.quoteAuthor ?? "")
                        .font(.title2)
                        .bold()
                        .opacity(quoteAuthorOpacity)
                        .onReceive(quoteAuthorTimer) { _ in
                            
                            withAnimation {
                                quoteAuthorOpacity = 1.0
                            }
                            
                            // Stop the timer
                            quoteAuthorTimer.upstream.connect().cancel()
                        }
 
                }
                .font(.title)
                .multilineTextAlignment(.center)
                
                Button {
                 
                    // Hide author and button
                    withAnimation {
                        viewModel.currentQuote = nil
                        quoteAuthorOpacity = 0.0
                        buttonOpacity = 0.0
                    }
                                        
                    // Get a new quote
                    Task {
                        await viewModel.fetchQuote()
                    }
                    
                    // Restart timers
                    quoteAuthorTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
                    buttonTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
                    
                } label: {
                 
                    Text("New Quote")
                    
                }
                .buttonStyle(.borderedProminent)
                .opacity(buttonOpacity)
                .onReceive(buttonTimer) { _ in
                    
                    withAnimation {
                        buttonOpacity = 1.0
                    }
                    
                    // Stop the timer
                    buttonTimer.upstream.connect().cancel()
                }
                
            }
            
            Spacer()
            
            Rectangle()
                .fill(Color.cyan)
                .stroke(.blue, lineWidth: 10)
                .frame(width: .infinity, height: 200)
                .overlay(alignment: .center) {
                    Text("Finder")
                    .foregroundStyle(.gray)
                    .font(.system(size: 50.0, weight: .bold, design: .default))
                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 0))
                    Text("Finder")
                    .foregroundStyle(.white)
                    .font(.system(size: 50.0, weight: .bold, design: .default))
                }
        }
        .ignoresSafeArea()

    }
}
 
#Preview {
    QuoteView()
}
