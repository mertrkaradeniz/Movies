//
//  Gradient.swift
//  Movies
//
//  Created by Mert Karadeniz on 3.05.2022.
//

import UIKit

@IBDesignable final class GradientView: UIView {

    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear

    override func draw(_ rect: CGRect) {
       layer.sublayers?.first?.removeFromSuperlayer()

       let gradient: CAGradientLayer = CAGradientLayer()
       gradient.frame = CGRect(origin: CGPoint.zero, size: self.bounds.size)
       gradient.colors = [startColor.cgColor, endColor.cgColor]
       layer.insertSublayer(gradient, at: 0)
    }
}
