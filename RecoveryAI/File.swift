//
//  GradientHeaderView.swift
//
//
//  Created by Bryan Marks on 2/12/17.
//
//

import Foundation

/// Custom header view that displays a gradient layer inside it
@IBDesignable class GradientHeaderView: UIView {
    
    /// Gradient layer that is added on top of the view
    var gradientLayer: CAGradientLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = frame
    }
    
    /// Top color of the gradient layer
    @IBInspectable var topColor: UIColor = UIColor.blackColor() {
        didSet {
            updateUI()
        }
    }
    
    /// Bottom color of the gradient layer
    @IBInspectable var bottomColor: UIColor = UIColor.clearColor() {
        didSet {
            updateUI()
        }
    }
    
    /// At which vertical point the layer should end
    @IBInspectable var bottomYPoint: CGFloat = 0.6 {
        didSet {
            updateUI()
        }
    }
    
    func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [topColor.CGColor, bottomColor.CGColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: bottomYPoint)
        layer.addSublayer(gradientLayer)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientLayer()
    }
    
    /**
     Initialises the view
     
     - parameter frame: frame to use
     
     - returns: self
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
}
