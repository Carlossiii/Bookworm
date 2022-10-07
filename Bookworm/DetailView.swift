//
//  DetailView.swift
//  Bookworm
//
//  Created by Carlos Vinicius on 06/10/22.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    var formattedDate: String {
        book.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
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
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
            
            Text(book.review ?? "no review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
            Text(formattedDate)
                .font(.caption)
                .padding(10)
                .foregroundColor(.secondary)
                .offset(x: -5, y: -5)
        }
        .navigationTitle(book.title ?? "Unknown book")
        .navigationBarTitleDisplayMode(.inline)
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
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        
        dismiss()
    }
}
