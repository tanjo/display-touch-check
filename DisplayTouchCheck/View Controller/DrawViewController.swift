//
//  DrawViewController.swift
//  DisplayTouchCheck
//

import UIKit

class DrawViewController: UIViewController {

    // MARK: - Variables

    // MARK: Outlet
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var subImageView: UIImageView!
    
    // MARK:
    
    let pen = Pen()
    
    // MARK: - Methods
    
    // MARK: UIViewController
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
    }
    
    // MARK: UIResponder
    
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            clearLines()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        pen.swipe = false
        pen.start = touch.location(in: view)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !pen.swipe {
            pen.draw(view: view, imageView: subImageView)
        }
        
        UIGraphicsBeginImageContext(view.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        subImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: pen.opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        subImageView.image = nil
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        pen.swipe = true
        let end =  touch.location(in: view)
        pen.end = end
        pen.draw(view: view, imageView: subImageView)

        pen.start = end
    }
    
    // MARK:
    
    func clearLines() {
        let alert = UIAlertController(title: "確認", message: "画面をクリアしますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "はい", style: .default) { (action) in
            self.mainImageView.image = nil
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "いいえ", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
