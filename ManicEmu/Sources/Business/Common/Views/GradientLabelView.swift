//
//  GradientLabelView.swift
//  ManicEmu
//
//  Created by Aushuang Lee on 2025/3/17.
//  Copyright © 2025 Manic EMU. All rights reserved.
//

class GradientLabelView: UILabel {
    private let gradientLayer = CAGradientLayer()
    private let maskLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientLayer.colors = Constants.Color.Gradient.reversed().map({ $0.cgColor })
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let image = renderer.image { context in
            self.layer.render(in: context.cgContext)
        }
        maskLayer.contents = image.withRenderingMode(.alwaysTemplate).cgImage
        gradientLayer.frame = bounds
        maskLayer.frame = gradientLayer.frame
        gradientLayer.mask = maskLayer
        textColor = .clear
    }
}
