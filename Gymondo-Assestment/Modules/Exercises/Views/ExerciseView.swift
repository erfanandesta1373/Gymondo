//
//  ExerciseView.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/28/1401 AP.
//

import SwiftUI
import Combine

struct ExerciseView: View {
    
    @ObservedObject var model: ExerciseViewModel
    private let imageSize: CGFloat = 50
    
    var body: some View {
        HStack {
            Image(uiImage: model.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageSize, height: imageSize, alignment: .center)
                .cornerRadius(8)
            Text(model.name)
                .font(.subheadline)
                .foregroundColor(.black)
            Spacer()
        }.padding(.horizontal, 12)
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(model: .init(name: "Exercise number 1", id: 1, imageLoader: Just(UIImage(named: "placeholder")!).eraseToAnyPublisher()))
    }
}
