//
//  AlertUIViewController.swift
//  Maze
//
//  Created by Ismail on 20/04/2021.
//

import UIKit

class AlertUIViewController: UIViewController {

    @IBOutlet private weak var smileyImageView: UIImageView!
    @IBOutlet private weak var moodLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var answerSheetButton: UIButton!
    @IBOutlet private weak var restartButton: UIButton!
    
    var score = String()
    var hasPassed = false
    var buttonAction: ((_ viewId: Int)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        if hasPassed {
            let color = Helper.Color.alertGreen
            smileyImageView.image = UIImage(named: "pass")
            moodLabel.text = "Woohoo, Congrats!"
            moodLabel.textColor =  color
            messageLabel.text = "Success all around."
            scoreLabel.text = score
            answerSheetButton.setTitleColor(color, for: .normal)
            restartButton.setTitleColor(.white, for: .normal)
            restartButton.backgroundColor = color
            restartButton.clipsToBounds = true
            restartButton.layer.cornerRadius = 8
            restartButton.setTitle("Take Exam Again", for: .normal)
            
        }else{
            let color = Helper.Color.alertRed
            smileyImageView.image = UIImage(named: "fail")
            moodLabel.text = "Uh Oh!"
            moodLabel.textColor =  color
            messageLabel.text = "Lets try again. You can do this!"
            scoreLabel.text = score
            answerSheetButton.setTitleColor(color, for: .normal)
            restartButton.setTitleColor(.white, for: .normal)
            restartButton.backgroundColor = color
            restartButton.clipsToBounds = true
            restartButton.layer.cornerRadius = 8
            restartButton.setTitle("Try Again", for: .normal)
        }
    }
    @IBAction func actionRestart(_ sender: Any) {
        dismiss(animated: true)
        buttonAction?(2)
        
    }
    @IBAction func actionViewAnswerSheet(_ sender: Any) {
        dismiss(animated: true)
        buttonAction?(1)
    }
    @IBAction func actionHome(_ sender: Any) {
        dismiss(animated: true)
        buttonAction?(3)
    }
    
}
