//
//  ViewController.swift
//  UpDownGame
//
//  Created by Valkyrie on 21/03/2019.
//  Copyright © 2019 Valkyrie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var turnCountLabel: UILabel!
    @IBOutlet var inputField: UITextField!
    
    
    var randomNumber: UInt32 = 0
    var turnCount = 0
    
    @IBAction func touchUpSubmitButton(_ sender: UIButton) {
        print("touch up submit button")
        
        guard let inputText = self.inputField.text,
            !inputText.isEmpty else {
                print("입력값 없음")
                return
        }
        
        guard let inputNumber: UInt32 = UInt32(inputText) else {
            print("입력값이 잘못 되었음")
            return
        }
        
        turnCount += 1
        self.turnCountLabel.text = "\(turnCount)"
        
        if inputNumber > randomNumber {
            self.resultLabel.text = "업!"
        } else if inputNumber < randomNumber {
            self.resultLabel.text = "다운!"
        } else {
            self.resultLabel.text = "정답!"
        }
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        print("touch up reset button")
        initializeGame()
//        inputField.becomeFirstResponder() // show keyboard
    }
    @IBAction func tapBackground(_ sender: UITapGestureRecognizer) {
        print("tap background view")
        inputField.resignFirstResponder() // hide keyboard
        //Todo.
        // 밑에 메서드 문서 확인
        //inputField endEditing(true)
        //self.view.endEditing(true)
    }
    
    func initializeGame() {
        self.randomNumber = arc4random() % 25
        self.turnCount = 0
        
        self.resultLabel.text = "Start!"
        self.turnCountLabel.text = "\(turnCount)"
        self.inputField.text = nil
        
        print("임의의 숫자 \(self.randomNumber)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeGame()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

