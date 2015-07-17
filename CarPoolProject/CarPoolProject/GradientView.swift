//
//  GradientView.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/4/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor(red:0.75, green:0.95, blue:0.47, alpha:1)
    @IBInspectable var secondColor: UIColor = UIColor(red:0.44, green:0.65, blue:0.99, alpha:1)
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
    
    override func drawRect(rect: CGRect) {
        
        let gl = CAGradientLayer()
        gl.frame = layer.bounds
        gl.colors = [firstColor.CGColor, secondColor.CGColor]
        gl.locations = [0.0, 1.0]
        gl.startPoint = startPoint
        gl.endPoint = endPoint
        layer.insertSublayer(gl, atIndex: 0)
    }

}
