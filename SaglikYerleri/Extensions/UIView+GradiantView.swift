//
//  UIView+GradiantView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 16.05.2023.
//

import UIKit

extension UIView {
    func applyGradient(colors: [CGColor], startPoint: CGPoint = CGPoint(x: 0, y: 1), endPoint: CGPoint = CGPoint(x: 1, y: 0)) {
            if let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer {
                gradientLayer.colors = colors
                gradientLayer.frame = self.bounds

                return
            }

            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colors
            gradient.startPoint = startPoint
            gradient.endPoint   = endPoint

            self.layer.insertSublayer(gradient, at: 0)
        }

}

