//
//  Config.swift
//  DisplayTouchCheck
//

import UIKit

class Config: NSObject {
    
    static let standard = Config()
    
    fileprivate let penSize = "pen-size"
    fileprivate let penColor = "pen-color"
    
    private override init() {
        super.init()
        
        UserDefaults.standard.register(defaults: [
            penSize: 10.0,
            penColor: try! NSKeyedArchiver.archivedData(withRootObject: UIColor.green, requiringSecureCoding: true)
        ])
    }
    
    var size: CGFloat {
        get {
            let size = UserDefaults.standard.float(forKey: penSize)
            if size < 1.0 {
                return 1.0
            }
            return CGFloat(size)
        }
        set {
            UserDefaults.standard.set(Float(newValue), forKey: penSize)
        }
    }
    
    var color: UIColor {
        get {
            guard let data = UserDefaults.standard.data(forKey: penColor) else {
                return .green
            }
            guard let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor else {
                return .green
            }
            return color
        }
        set {
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: true) else {
                return
            }
            UserDefaults.standard.set(data, forKey: penColor)
        }
    }
}
