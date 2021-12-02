//
//  ViewController.swift
//  Project27
//
//  Created by PEDRO HENRIQUE CALADO on 11/29/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectangle()
    }


    @IBAction func redrawTapped(_ sender: UIButton) {
        currentDrawType += 1
        
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 500, height: 500))
        print(view.safeAreaLayoutGuide.layoutFrame.width)
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 500, height: 500).insetBy(dx: 15, dy: 15)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.blue.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 500, height: 500))
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 500, height: 500).insetBy(dx: 16.5, dy: 16.5)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.blue.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
        
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 500, height: 500))
        
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<10 {
                for col in 0..<10 {
                    if (row + col).isMultiple(of: 2) {
                        ctx.cgContext.fill(CGRect(x: col * 50, y: row * 50, width: 50, height: 50))
                        
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 256, height: 256))
        
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 128, y: 128)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            for _ in 0..<rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -64, y: -64, width: 128, height: 128))
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
            
        }
        
        imageView.image = image
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 256, height: 256))
        
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 128, y: 128)
            var first = true
            var length: CGFloat = 128
            
            for _ in 0..<256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.blue.cgColor)
            ctx.cgContext.strokePath()
            
        }
        
        imageView.image = image
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 256, height: 256))
        
        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "testing this string here"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 16, y: 16, width: 200, height: 50), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
//            mouse?.draw(at: CGPoint(x: 25, y: 50))
            mouse?.draw(in: CGRect(x: 50, y: 50, width: 100, height: 200))
        }
        
        imageView.image = image
    }
}

