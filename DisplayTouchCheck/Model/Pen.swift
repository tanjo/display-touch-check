//
//  Pen.swift
//  DisplayTouchCheck
//

import UIKit

class Pen {
    var color = UIColor.green
    var width: CGFloat = 1.0
    var opacity: CGFloat = 1.0
    var end = CGPoint.zero
    var start = CGPoint.zero
    var swipe = false
    
    func draw(view: UIView, imageView: UIImageView) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        imageView.image?.draw(in: view.bounds)
        context.move(to: start)
        context.addLine(to: end)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(width)
        context.setStrokeColor(color.cgColor)
        
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        imageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
}
