//
//  UIViewSample.swift
//  DemoApp
//
//  Created by rajasekar.r on 15/11/24.
//

import Foundation
import UIKit
import SwiftUI
import UIKitHelper

struct CustomShapeMask: Shape {
    func path(in rect: CGRect) -> Path {
        let path = customShape(rect, cornerRadius: 10)
        return Path(path.cgPath)
    }
}

struct CustomShapeView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.clear)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.white, .gray, .black]), startPoint: .top, endPoint: .bottom)
                )
            Color.green
                .frame(width: 350, height: 150)
                .mask(CustomShapeMask())
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CustomShapeView()
}


#Preview {
    UIViewContainer(uiView: MaskCheckView())
        .ignoresSafeArea()
}


class MaskCheckView: UIBaseView {
    let rectangle = UIView()
    let gradient = CAGradientLayer()

    override func loadView() {
        addSubview(rectangle)
        rectangle.backgroundColor = .red

        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        self.layer.insertSublayer(gradient, at: 0)

        super.loadView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
        let path = customShape(self.rectangle.bounds, cornerRadius: 10)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.rectangle.layer.mask = maskLayer
    }
    
    override func setupConstraints() {
        rectangle.setSize(width: 350, height: 150)
        rectangle.centerToSuperView()
    }
}

func customShape(_ bounds: CGRect, cornerRadius radius: CGFloat) -> UIBezierPath {
    let path = UIBezierPath()

    path.move(to: CGPoint(x: 0, y: bounds.height))

    // top left corner
    path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: true)

    // top right corner
    path.addArc(withCenter: CGPoint(x: bounds.width - radius, y: radius), radius: radius, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: true)

    // mid top right corner
    path.addArc(withCenter: CGPoint(x: bounds.width - radius, y: bounds.height / 2 - radius), radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)

    // mid inverted curve
    path.addArc(withCenter: CGPoint(x: bounds.width * 2/3 + radius, y: bounds.height / 2 + radius), radius: radius, startAngle: CGFloat.pi * 3 / 2, endAngle: CGFloat.pi, clockwise: false)

    // mid bottom right
    path.addArc(withCenter: CGPoint(x: bounds.width * 2/3 - radius, y: bounds.height - radius), radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)

    // bottom left
    path.addArc(withCenter: CGPoint(x: radius, y: bounds.height - radius), radius: radius, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)

    path.close()

    // small rectangle
    let xOffset: CGFloat = bounds.width * 2/3 + 8
    let yOffset: CGFloat = bounds.height / 2 + 8
    path.append(
        UIBezierPath(roundedRect: .init(x: xOffset, y: yOffset, width: bounds.width - xOffset, height: bounds.height - yOffset), cornerRadius: radius)
    )

    return path
}



class UIBaseView: UIView {
    var isDoneConstraintSetup = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    override func updateConstraints() {
        if !isDoneConstraintSetup {
            isDoneConstraintSetup = true
            setupConstraints()
        }
        super.updateConstraints()
    }
    
    func loadView() {
        self.setNeedsUpdateConstraints()
    }
    func setupConstraints() { }
}
