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
    
    override func viewDidAppear(_ animated: Bool) {
        pen.updateStatus()
    }
    
    // MARK: UIResponder
    
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            showActionSheet()
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
        pen.render(view: view, renderImageView: mainImageView, originalImageView: subImageView)
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
    
    func share() {
        guard let image = mainImageView.image else {
            return
        }
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activity, animated: true, completion: nil)
    }
    
    func showActionSheet() {
        let alert = UIAlertController(title: "アクション", message: "選べ", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "画面をクリア", style: .default) { (action) in
            self.mainImageView.image = nil
        })
        alert.addAction(UIAlertAction(title: "共有", style: .default) { (action) in
            self.share()
        })
        alert.addAction(UIAlertAction(title: "設定", style: .default, handler: { (action) in
            guard let storyboard = self.storyboard else {
                return
            }
            let viewController = storyboard.instantiateViewController(withIdentifier: "ConfigViewController")
            self.present(viewController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}
