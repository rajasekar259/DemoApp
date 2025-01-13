//
//  UIViewControllerSample.swift
//  DemoApp
//
//  Created by rajasekar.r on 15/11/24.
//

import Foundation
import UIKit
import SwiftUI
import UIKitHelper

struct UIViewControllerSampleView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewControllerSample {
        UIViewControllerSample()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

#Preview {
    UIViewControllerSampleView()
        .ignoresSafeArea()
}



class UIViewControllerSample: UIViewController {
    
    lazy var label = UILabel()
    lazy var label2 = UILabel()
    lazy var stackView = UIStackView()
    lazy var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = .zero
    
        button.setTitle("Change Layout", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemBlue.withAlphaComponent(0.5), for: .highlighted)
        button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
        button.backgroundColor = .systemGray
        
        label.text = "Label 1"
        label.backgroundColor = .green
        label.textAlignment = .center
        
        label2.text = "Label 2"
        label2.backgroundColor = .yellow
        label2.textAlignment = .center
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(label2)
        
        [label, label2, button].forEach {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 10
        }
        
        view.addSubview(stackView)
    }
    
    @objc func onButtonClick() {
        UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.8, animations: { [unowned self] in
            stackView.axis = stackView.axis == .horizontal ? .vertical : .horizontal
        }).startAnimation()
    }
    
    func setupConstraints() {
        stackView.fillSuperView()
        stackView.insetsLayoutMarginsFromSafeArea = true
    }

}
