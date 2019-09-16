//
//  ConfigViewController.swift
//  DisplayTouchCheck
//

import UIKit

class ConfigViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var sizeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeTextField.text = "\(Config.standard.size)"
        sizeTextField.delegate = self
        sizeTextField.keyboardType = .decimalPad
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: Private methods
    
    func saveSize() {
        if let text = sizeTextField.text, let size = Float(text) {
            Config.standard.size = CGFloat(size)
        }
    }
    
    func saveColor(color: UIColor) {
        Config.standard.color = color
    }
    
    @objc func closeKeyboard() {
        if self.sizeTextField.isFirstResponder {
            self.sizeTextField.resignFirstResponder()
        }
    }
    
    // MARK: - UITextField
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveSize()
    }
    
    // MARK: - Actions
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Colors
    
    @IBAction func clickWhiteColor(_ sender: Any) {
        saveColor(color: .white)
    }
    
    @IBAction func clickYellowColor(_ sender: Any) {
        saveColor(color: .yellow)
    }
    
    @IBAction func clickRedColor(_ sender: Any) {
        saveColor(color: .red)
    }
    
    @IBAction func clickPurpleColor(_ sender: Any) {
        saveColor(color: .purple)
    }
    
    @IBAction func clickOrangeColor(_ sender: Any) {
        saveColor(color: .orange)
    }
    
    @IBAction func clickMagentaColor(_ sender: Any) {
        saveColor(color: .magenta)
    }
    
    @IBAction func clickGreenColor(_ sender: Any) {
        saveColor(color: .green)
    }
    
    @IBAction func clickCyanColor(_ sender: Any) {
        saveColor(color: .cyan)
    }
    
    @IBAction func clickBrownColor(_ sender: Any) {
        saveColor(color: .brown)
    }
    
    @IBAction func clickBlueColor(_ sender: Any) {
        saveColor(color: .blue)
    }
    
    @IBAction func clickBlackColor(_ sender: Any) {
        saveColor(color: .black)
    }
    
    @IBAction func clickGrayColor(_ sender: Any) {
        saveColor(color: .gray)
    }
}
