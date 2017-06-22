//
//  KeyboardViewController.swift
//  Appcoda Keyboard
//
//  Created by Joyce Echessa on 10/27/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var capsLockOn = true
    
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    
    @IBOutlet weak var charSet1: UIView!
    @IBOutlet weak var charSet2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        view = objects[0] as! UIView;
        
        charSet2.isHidden = true
    }
    
    @IBAction func nextKeyboardPressed(_ button: UIButton) {
        advanceToNextInputMode()
    }
    
    @IBAction func capsLockPressed(_ button: UIButton) {
        capsLockOn = !capsLockOn
        
        changeCaps(row1)
        changeCaps(row2)
        changeCaps(row3)
        changeCaps(row4)
    }
    
    @IBAction func keyPressed(_ button: UIButton) {
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
            }, completion: {(_) -> Void in
                button.transform =
                    CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        })
    }
    
    @IBAction func backSpacePressed(_ button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func spacePressed(_ button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    @IBAction func returnPressed(_ button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func charSetPressed(_ button: UIButton) {
        if button.titleLabel!.text == "1/2" {
            charSet1.isHidden = true
            charSet2.isHidden = false
            button.setTitle("2/2", for: UIControlState())
        } else if button.titleLabel!.text == "2/2" {
            charSet1.isHidden = false
            charSet2.isHidden = true
            button.setTitle("1/2", for: UIControlState())
        }
    }
    
    func changeCaps(_ containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let buttonTitle = button.titleLabel!.text
                if capsLockOn {
                    let text = buttonTitle!.uppercased()
                    button.setTitle("\(text)", for: UIControlState())
                } else {
                    let text = buttonTitle!.lowercased()
                    button.setTitle("\(text)", for: UIControlState())
                }
            }
        }
    }
    
}
