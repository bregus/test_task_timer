//
//  ViewController.swift
//  timer
//
//  Created by Рома Сумороков on 16/03/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
    let handleButton = UIButton()
    let resetButton = UIButton()
    var timer = Timer()
    var startTime = 0.0
    var stopTime = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 12/255.0, green: 12/255.0, blue: 12/255.0, alpha: 1)
        label.center = view.center
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        label.text = "00:00,00"
        handleButton.setTitle("Start", for: .normal)
        handleButton.setTitleColor(.lightGreen, for: .normal)
        handleButton.backgroundColor = .darkGreen
        handleButton.frame = CGRect(x: label.frame.origin.x - 90,y: view.center.y - 40, width: 80, height: 80)
        handleButton.layer.cornerRadius = handleButton.frame.width / 2
        handleButton.addTarget(self, action: #selector(ViewController.pressed(sender:)), for: .touchDown)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.backgroundColor = UIColor.darkGray
        resetButton.frame = CGRect(x: label.frame.origin.x + label.frame.width + 10,y: view.center.y - 40, width: 80, height: 80)
        resetButton.layer.cornerRadius = resetButton.frame.width / 2
        resetButton.addTarget(self, action: #selector(ViewController.reset(sender:)), for: .touchDown)
        self.view.addSubview(handleButton)
        self.view.addSubview(resetButton)
        self.view.addSubview(label)
    }

    @objc func pressed(sender: UIButton!) {
        if (timer.isValid) {
            timer.invalidate()
            resetButton.isEnabled = true
            resetButton.alpha = 1.0
            stopTime = NSDate.timeIntervalSinceReferenceDate
            handleButton.backgroundColor = .darkGreen
            handleButton.setTitleColor(.lightGreen, for: .normal)
            handleButton.setTitle("Start", for: .normal)
        } else {
            resetButton.isEnabled = false
            resetButton.alpha = 0.5
            if startTime == 0.0 {
                startTime = NSDate.timeIntervalSinceReferenceDate
            } else {
                startTime += NSDate.timeIntervalSinceReferenceDate - stopTime
            }
            self.timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(ViewController.updateLabel), userInfo: nil, repeats: true)
            handleButton.backgroundColor = .darkRed
            handleButton.setTitleColor(.lightRed, for: .normal)
            handleButton.setTitle("Stop", for: .normal)
        }
        
    }
    
    @objc func reset(sender: UIButton!) {
        startTime = 0.0
        stopTime = 0.0
        label.text = "00:00,00"
        handleButton.backgroundColor = .darkGreen
        handleButton.setTitleColor(.lightGreen, for: .normal)
        handleButton.setTitle("Start", for: .normal)
    }
    
    @objc func updateLabel() {
        let time = NSDate.timeIntervalSinceReferenceDate - startTime
        label.text = time.stringFromTimeInterval()
    }

}

extension UIColor {
    open class var darkGreen: UIColor { get {return UIColor.init(red: 27.0/255.0, green: 54.0/255.0, blue: 32.0/255.0, alpha: 1)} }
    
    open class var lightGreen: UIColor { get {return UIColor.init(red: 55/255.0, green: 170/255.0, blue: 67/255.0, alpha: 1.0)} }
    
    open class var darkRed: UIColor { get {return UIColor.init(red: 46/255.0, green: 15/255.0, blue: 17/255.0, alpha: 1.0)} }

    open class var lightRed: UIColor { get {return UIColor.init(red: 190/255.0, green: 41/255.0, blue: 41/255.0, alpha: 1.0)} }
}

extension TimeInterval{
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 100)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        
        return String(format: "%0.2d:%0.2d,%0.2d",minutes,seconds,ms)
    }
}
