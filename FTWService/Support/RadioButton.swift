//
//  KGRadioButton.swift
//  newOrzu
//
//  Created by MacOs User on 11/21/19.
//  Copyright © 2019 Orzu. All rights reserved.
//

import UIKit

@IBDesignable
public class KGRadioButton: UIButton {
    
    internal var outerCircleLayer = CAShapeLayer()
    internal var innerCircleLayer = CAShapeLayer()
    
    
    @IBInspectable public var outerCircleColor: UIColor = #colorLiteral(red: 0.3536864519, green: 0.7271710634, blue: 0.3864591122, alpha: 1) {
        didSet {
            outerCircleLayer.strokeColor = outerCircleColor.cgColor
        }
    }
    @IBInspectable public var innerCircleCircleColor: UIColor = #colorLiteral(red: 0.3536864519, green: 0.7271710634, blue: 0.3864591122, alpha: 1){
        didSet {
            setFillState()
        }
    }
    
    @IBInspectable public var outerCircleLineWidth: CGFloat = 3.0 {
        didSet {
            setCircleLayouts()
        }
    }
    @IBInspectable public var innerCircleGap: CGFloat = 3.0 {
        didSet {
            setCircleLayouts()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
    }
    // MARK: Initialization
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInitialization()
    }
    internal var setCircleRadius: CGFloat {
        let width = bounds.width
        let height = bounds.height
        
        let length = width > height ? height : width
        return (length - outerCircleLineWidth) / 2
    }
    
    private var setCircleFrame: CGRect {
        let width = bounds.width
        let height = bounds.height
        
        let radius = setCircleRadius
        let x: CGFloat
        let y: CGFloat
        
        if width > height {
            y = outerCircleLineWidth / 2
            x = (width / 2) - radius
        } else {
            x = outerCircleLineWidth / 2
            y = (height / 2) - radius
        }
        
        let diameter = 2 * radius
        return CGRect(x: x, y: y, width: diameter, height: diameter)
    }
    
    private var circlePath: UIBezierPath {
        return UIBezierPath(roundedRect: setCircleFrame, cornerRadius: setCircleRadius)
    }
    
    private var fillCirclePath: UIBezierPath {
        let trueGap = innerCircleGap + (outerCircleLineWidth / 2)
        return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: trueGap, dy: trueGap), cornerRadius: setCircleRadius)
        
    }
    
    private func customInitialization() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        outerCircleLayer.strokeColor = outerCircleColor.cgColor
        layer.addSublayer(outerCircleLayer)
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(innerCircleLayer)
        
        setFillState()
    }
    
    private func setCircleLayouts() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.path = circlePath.cgPath
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.path = fillCirclePath.cgPath
    }
    
    // MARK: Custom
    private func setFillState() {
        if self.isSelected {
            innerCircleLayer.fillColor = outerCircleColor.cgColor
        } else {
            innerCircleLayer.fillColor = UIColor.clear.cgColor
        }
    }
    // Overriden methods.
    override public func prepareForInterfaceBuilder() {
        customInitialization()
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        setCircleLayouts()
    }
    override public var isSelected: Bool {
        didSet {
            setFillState()
        }
    }
}
class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

