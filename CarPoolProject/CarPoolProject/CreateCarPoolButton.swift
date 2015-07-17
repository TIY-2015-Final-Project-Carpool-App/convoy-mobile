//
//  CreateCarPoolButton.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/4/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

@IBDesignable class CreateCarPoolButton: UIButton {

    @IBInspectable var fillColor: UIColor = UIColor.redColor()
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var strokeColor: UIColor = UIColor.blackColor()
    @IBInspectable var strokeWidth: CGFloat = 1
    
    
    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext()
        let insetRect = CGRectInset(rect, strokeWidth / 2, strokeWidth / 2)
        
        let path = UIBezierPath(roundedRect: insetRect, cornerRadius: cornerRadius)
        
        fillColor.set()
        
        CGContextAddPath(context, path.CGPath)
        CGContextFillPath(context)
        
        strokeColor.set()
        
        CGContextSetLineWidth(context, strokeWidth)
        CGContextAddPath(context, path.CGPath)
        CGContextStrokePath(context)
        
        
        
        
    }

    

}
