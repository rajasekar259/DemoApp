//
//  Shimmer.swift
//  DemoApp
//
//  Created by rajasekar.r on 09/12/24.
//

import Foundation
import SwiftUI

public struct Shimmer: AnimatableModifier {

    private let gradient: Gradient

    @State private var position: CGFloat = 0

    public var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }

    private let animation = Animation
        .linear(duration: 2)
        .delay(0.3)
        .repeatForever(autoreverses: false)

    init(sideColor: Color = Color(white: 0.25), middleColor: Color = .white) {
        gradient = Gradient(colors: [sideColor, middleColor, sideColor])
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                LinearGradient(
                    gradient: gradient,
                    startPoint: .init(x: position - 0.2 * (1 - position), y: 0),
                    endPoint: .init(x: position + 0.2 * position, y: 0)
                )
                .mask(content)
            }
            .onAppear {
                withAnimation(animation) {
                    position = 1
                }
            }
    }
}


#Preview {
    Text("Text Label")
        .font(.largeTitle)
        .fontWeight(.semibold)
        .modifier(Shimmer(sideColor: .red, middleColor: .blue))

}
