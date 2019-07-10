//
//  ViewController.swift
//  DISCTest
//
//  Created by Valkyrie on 02/07/2019.
//  Copyright © 2019 Valkyrie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func touchUpStartButton(_ sender: UIButton) {
        guard let name: String = self.nameField.text, !name.isEmpty else {
            let alert = UIAlertController(title: "알림", message: "이름을 입력해주세요", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        UserInfo.shared.name = self.nameField.text
        
        self.performSegue(withIdentifier: "PresentTest", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameField.text = nil
    }

}

