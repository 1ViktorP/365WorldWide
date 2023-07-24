//
//  Extentions+UIKIt.swift
//  365WorldWide
//
//  Created by MacBook on 24.07.2023.
//

import UIKit
import AVFoundation

extension UIColor {
    static let mainYellowColor = UIColor(red: 1, green: 0.8824, blue: 0.2745, alpha: 1.0)
    static let cellBGColor = UIColor(red: 0.149, green: 0.1804, blue: 0.2235, alpha: 1.0)
    
}

extension UIView {
    func addEdgesConstraints(from parentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parentView.topAnchor),
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
        ])
    }
}

extension CAGradientLayer {
    static func addGradientLayer(bounds: CGRect,cornerRadius: CGFloat, colors: [UIColor], isHorizontal: Bool = false)  -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.masksToBounds = true
        if isHorizontal {
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        gradient.cornerRadius = cornerRadius
        gradient.colors = colors.map { $0.cgColor }
        return gradient
    }
}

extension UIDevice {
    static func vibrate() {
        if UserDefaults.standard.bool(forKey: "vibrations") == true {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
}


extension CALayer {
    
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
