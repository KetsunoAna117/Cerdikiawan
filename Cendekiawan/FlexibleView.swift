//
//  FlexibleView.swift
//  Cendekiawan
//
//  Created by Hans Arthur Cupiterson on 24/06/24.
//

import SwiftUI

struct FlexibleView: View {
    let availableWidth: CGFloat
    let views: [AnyView]
    
    var body: some View {
        var width: CGFloat = 0
        var rows: [[AnyView]] = [[]]
        
        for view in views {
            let viewWidth = view.width + 10
            
            if width + viewWidth > availableWidth { // if overflow, create another row
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
        .frame(width: availableWidth)
    }
}

#Preview {
    FlexibleView(availableWidth: 600, views: [
        AnyView(
            renderTextWithPlaceHolders(availableWidth: 600)
        )
    ])
}

//func renderTextWithPlaceHolders(availableWidth: CGFloat) -> some View {
//    let vm = QuizFillBlankViewModel(
//        questions: QuizModelData().rumpang4[0].quizStory,
//        choices: QuizModelData().rumpang4[0].quizChoiceList
//    )
//
//    let parts = vm.questions
//    var views: [AnyView] = []
//    
//    for index in parts.indices {
//        views.append(AnyView(
//            Text(parts[index])
//                .font(.body)
//        ))
//        
//        if index < parts.indices.last! {
//            // this will append rectangle to the paragraph
//            views.append(AnyView(
//                Rectangle()
//                    .frame(width: 100, height: 20)
//                    
//            ))
//        }
//    }
//    return VStack {
//        FlexibleView(availableWidth: availableWidth, views: views)
//    }
//}

func renderTextWithPlaceHolders(availableWidth: CGFloat) -> some View {
    let parts = QuizModelData().rumpang6[0].quizStory.split(separator: " ")
    var views: [AnyView] = []
    
    for index in parts.indices {
        if parts[index] == "_" {
            views.append(AnyView(
                Rectangle()
                    .frame(width: 100, height: 20)
            ))
        }
        else {
            views.append(AnyView(
                Text(parts[index])
                    .font(.body)
            ))
        }

        
    }
    return VStack {
        FlexibleView(availableWidth: availableWidth, views: views)
    }
}
