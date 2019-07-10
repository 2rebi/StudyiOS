//
//  QuestionViewController.swift
//  DISCTest
//
//  Created by Valkyrie on 02/07/2019.
//  Copyright © 2019 Valkyrie. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    enum ButtonTag: Int {
        case d = 101
        case i, s, c
    }
    
    var questionIndex: Int!

    @IBOutlet weak var backButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.questionIndex = self.questionIndex ?? 0
        if self.questionIndex < 1 {
            self.backButton.isHidden = true
        }
        
        let question = Question.all[questionIndex]
        guard let dButton = self.view.viewWithTag(ButtonTag.d.rawValue) as? UIButton else { return }
        dButton.setTitle(question.d, for: .normal)
        guard let iButton = self.view.viewWithTag(ButtonTag.i.rawValue) as? UIButton else { return }
        iButton.setTitle(question.i, for: .normal)
        guard let sButton = self.view.viewWithTag(ButtonTag.s.rawValue) as? UIButton else { return }
        sButton.setTitle(question.s, for: .normal)
        guard let cButton = self.view.viewWithTag(ButtonTag.c.rawValue) as? UIButton else { return }
        cButton.setTitle(question.c, for: .normal)
    }
    
    @IBAction func touchUpBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpAnswerButton(_ sender: UIButton) {
        guard let tag = ButtonTag(rawValue: sender.tag) else {
            return
        }
        
        switch tag {
        case .d:
            UserInfo.shared.score.d += 1
        case .i:
            UserInfo.shared.score.i += 1
        case .s:
            UserInfo.shared.score.s += 1
        case .c:
            UserInfo.shared.score.c += 1
        }
        
        let nextIndex = self.questionIndex + 1
        
        if Question.all.count > nextIndex, let nextViewController: QuestionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController {
            nextViewController.questionIndex = nextIndex
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            self.performSegue(withIdentifier: "ShowResult", sender: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
