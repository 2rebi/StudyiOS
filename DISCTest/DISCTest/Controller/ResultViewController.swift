//
//  ResultViewController.swift
//  DISCTest
//
//  Created by Valkyrie on 02/07/2019.
//  Copyright © 2019 Valkyrie. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameLabel.text = UserInfo.shared.name
        self.percentageLabel.text = UserInfo.shared.scorePercentage
        
        guard let result = UserInfo.shared.hightestScoreResult else { return }
        
        self.titleLabel.text = result.title
        self.descriptionTextView.text = result.typeDescription
    }
    

    @IBAction func touchUpDismissButton(_ sender: UIButton) {
        self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
