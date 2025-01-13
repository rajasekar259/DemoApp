//
//  ContentView.swift
//  DemoApp
//
//  Created by rajasekar.r on 15/11/24.
//

import SwiftUI
import UIKit
import RSlideSwitch

struct ContentView: View {
    @State var isOn = false

    @State var showMaskCell = false
    @State var showTextShimmerAnimation = false
    @State var showLayoutChangeAnimation = false
    var body: some View {
        NavigationView {
            VStack {
                Button("Custom Rectangle") {
                    showMaskCell.toggle()
                }

                Button("Text Shimmer Animation") {
                    showTextShimmerAnimation.toggle()
                }

                Button("Layout Change Animation") {
                    showLayoutChangeAnimation.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
            .navigationTitle("UIKit/SWiftUI Demo")
            .padding()
            .sheet(isPresented: $showTextShimmerAnimation) {
                Text("Text Label")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .modifier(Shimmer(sideColor: .red, middleColor: .blue))
            }
            .sheet(isPresented: $showLayoutChangeAnimation) {
                UIViewControllerSampleView()
            }
            .sheet(isPresented: $showMaskCell) {
                UIViewSampleView(uiView: MaskCheckView())
            }
        }
    }
}

#Preview {
    ContentView()
}
