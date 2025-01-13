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


struct UIViewSampleView<View>: UIViewRepresentable where View: UIView {
    let uiView: View
    
    func makeUIView(context: Context) -> View {
        uiView
    }
    
    func updateUIView(_ uiView: View, context: Context) {
    }
}


#Preview {
    UIViewSampleView(uiView: MaskCheckView())
}


class MaskCheckView: UIBaseView {
    let rectangle = UIView()
    
    override func loadView() {
        addSubview(rectangle)
        rectangle.backgroundColor = .red
        backgroundColor = .green
        super.loadView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        maskContent(self.rectangle.bounds, cornerRadius: 15)
    }
    
    override func setupConstraints() {
        rectangle.setSize(width: 350, height: 150)
        rectangle.centerToSuperView()
        
//        let mask = CAShapeLayer()
//        let path = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: 200, height: 100), byRoundingCorners: [.topLeft, .bottomLeft, .bottomRight], cornerRadii: .init(width: 10, height: 10))
//        
//
//        
//        path.append(UIBezierPath(roundedRect: .init(x: 200, y: 0, width: 100, height: 50), byRoundingCorners: [.topRight, .bottomRight], cornerRadii: .init(width: 10, height: 10)))
//        
//        path.append(UIBezierPath(roundedRect: .init(x: 200, y: 50, width: 100, height: 50), byRoundingCorners: .allCorners, cornerRadii: .init(width: 0, height: 0)))
//        
//        path.append(UIBezierPath(roundedRect: .init(x: 200, y: 50, width: 100, height: 50), byRoundingCorners: .topLeft, cornerRadii: .init(width: 10, height: 10)))
//        
//        path.append(UIBezierPath(roundedRect: .init(x: 210, y: 60, width: 90, height: 40), byRoundingCorners: .allCorners, cornerRadii: .init(width: 10, height: 10)))
//        
//    
//        mask.path = path.cgPath
////        mask.fillColor = UIColor.yellow.cgColor
////        mask.strokeColor = UIColor.blue.cgColor
////        mask.lineWidth = 5
//        mask.fillRule = .evenOdd
//        rectangle.layer.mask = mask
        
    }
    
    
    func maskContent(_ bounds: CGRect, cornerRadius radius: CGFloat) {
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
 
        let xOffset: CGFloat = bounds.width * 2/3 + 8
        let yOffset: CGFloat = bounds.height / 2 + 8
        
        path.append(
            UIBezierPath(roundedRect: .init(x: xOffset, y: yOffset, width: bounds.width - xOffset, height: bounds.height - yOffset), cornerRadius: radius)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
//        maskLayer.fillRule = .evenOdd
        self.rectangle.layer.mask = maskLayer
    }
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
