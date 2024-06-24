//
//  QuizFillBlankView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 19/06/24.
//

import SwiftUI

struct QuizFillBlankView: View {
    @ObservedObject var vm: QuizFillBlankViewModel
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                renderTextWithPlaceHolders(availableWidth: 600)
                    .frame(width: 600)
            }
        }
        .padding(.horizontal, 50)
    }
    
    func renderTextWithPlaceHolders(availableWidth: CGFloat) -> some View{
        let parts = vm.questions.components(separatedBy: "___")
        var views: [AnyView] = []
        
        for index in parts.indices {
            views.append(AnyView(Text(parts[index])))
            
            if index < parts.indices.last! {
                views.append(AnyView(
                    Rectangle()
                        .frame(width: 50, height: 20)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 2)
                ))
            }
        }
        
        return VStack {
            FlexibleView(availableWidth: availableWidth, views: views)
        }
    }
}

struct FlexibleView: View {
    let availableWidth: CGFloat
    let views: [AnyView]
    
    var body: some View {
        var width: CGFloat = 0
        var rows: [[AnyView]] = [[]]
        
        for view in views {
            let viewWidth = view.width
            
            if width + viewWidth > availableWidth {
                rows.append([view])
                width = viewWidth
            } else {
                rows[rows.count - 1].append(view)
                width += viewWidth
            }
        }
        
        return VStack(alignment: .leading, content: {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(rows[rowIndex].indices, id: \.self) { viewIndex in
                        rows[rowIndex][viewIndex]
                    }
                }
            }
        })
    }
}

extension View {
    var width: CGFloat {
        let widthConstraint = UIHostingController(rootView: self).view.intrinsicContentSize.width
        return widthConstraint
    }
}
                             
         

#Preview {
    QuizFillBlankView(
        vm: QuizFillBlankViewModel(
            questions: "Apa yang dicari orang ___? Bintang ___. Tanpa itu, kita mempunyai ___ dan tidak akan mendapatkan ___",
            choices: [
                Choice(choiceID: 1, choiceText: "Sigma"),
                Choice(choiceID: 2, choiceText: "Skibidi"),
                Choice(choiceID: 3, choiceText: "L Rizz"),
                Choice(choiceID: 4, choiceText: "Gyatt")
            ]
        )
    )
}
