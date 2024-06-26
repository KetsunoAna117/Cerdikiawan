//
//  BookshelfView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 26/06/24.
//

import SwiftUI

struct BookshelfView: View {
    @Binding var userLevel: Int
    let booksPerRow = 13
    let rowHeight: CGFloat = 100
    let verticalSpacing: CGFloat = 35
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("ShelfBase")
                .resizable()
                .frame(width: 270, height: 520)
            VStack(alignment: .leading, spacing: verticalSpacing) {
                ForEach(0..<4, id: \.self) { rowIndex in
                    BookRowView(bookInRow: booksInRow(rowIndex: rowIndex))
                }
            }
            .padding(.leading, 20) // Adjust left padding to match the shelf image
            .padding(.top, 50)     // Adjust top padding to match the shelf image
        }
        
    }
    
//    func numberOfRows() -> Int {
//        let totalBooks = userLevel
//        return Int(ceil(Double(totalBooks) / Double(booksPerRow)))
//    }
    
    // calculate how many books in a row
    func booksInRow(rowIndex: Int) -> Int {
        let totalBooks = userLevel
        let fullRows = totalBooks / booksPerRow
        let remainingBooks = totalBooks % booksPerRow
        
        if rowIndex < fullRows {
            return booksPerRow
        } else if rowIndex == fullRows {
            return remainingBooks
        } else {
            return 0
        }
    }
}

struct BookRowView: View {
    var bookInRow: Int
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 1){
            ForEach(0..<bookInRow, id: \.self) { index in
                BookView(column: index)
            }
        }
    }
}

struct BookView: View {
    let column: Int
    @State private var bookImage: BookStyle = BookStyle.red
    
    var body: some View {
        Image(bookImage.image)
            .onAppear(){
                setBookColor()
            }
    }
    
    func setBookColor(){
        if column >= 0 && column <= 4 {
            bookImage = BookStyle.red
        }
        else if column >= 5 && column <= 7 {
            bookImage = BookStyle.orange
        }
        else if column >= 8 && column <= 9 {
            bookImage = BookStyle.green
        }
        else if column == 10 {
            bookImage = BookStyle.blue
        }
        else {
            bookImage = BookStyle.black
        }
    }
    
    enum BookStyle {
        case red
        case orange
        case green
        case blue
        case black
        
        var image: String {
            switch self {
            case .red:
                "Book1"
            case .orange:
                "Book2"
            case .green:
                "Book3"
            case .blue:
                "Book4"
            case .black:
                "Book5"
            }
        }
    }
}

#Preview {
    BookshelfView(
        userLevel: .constant(40)
    )
}
