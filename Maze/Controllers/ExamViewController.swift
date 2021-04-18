//
//  ExamViewController.swift
//  Maze
//
//  Created by Ismail on 11/04/2021.
//

import UIKit
import SnapKit

class ExamViewController: UIViewController {
    
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Helper.Color.init().backgroundGreen
        return view
    }()
    var questionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor  = UIColor(hex: "#333333FF")
        label.font = UIFont(name: "ApercuPro-Regular", size: 16)
        label.numberOfLines = 5
        return label
    }()
    var optionAButton: OptionButton = {
        let optionButton = OptionButton()
        optionButton.tag = 0
        return optionButton
    }()
    var optionBButton: OptionButton = {
        let optionButton = OptionButton()
        optionButton.tag = 1
        return optionButton
    }()
    var optionCButton: OptionButton = {
        let optionButton = OptionButton()
        optionButton.tag = 2
        return optionButton
    }()
    var optionDButton: OptionButton = {
        let optionButton = OptionButton()
        optionButton.tag = 3
        return optionButton
    }()
    
    let currentQuestion: Question!
    let dataController: DataController!
    
    init(with question: Question, dataController: DataController){
        self.currentQuestion = question
        self.dataController = dataController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //
        setupQuestionViews()
        
        backgroundView.addSubview(questionImageView)
        backgroundView.addSubview(questionLabel)
        backgroundView.addSubview(optionAButton)
        backgroundView.addSubview(optionBButton)
        backgroundView.addSubview(optionCButton)
        backgroundView.addSubview(optionDButton)
        view.addSubview(backgroundView)
        setViewContraints()
        
        optionAButton.addTarget(self, action: #selector(selectedOption(_:)), for: .touchUpInside)
        optionBButton.addTarget(self, action: #selector(selectedOption(_:)), for: .touchUpInside)
        optionCButton.addTarget(self, action: #selector(selectedOption(_:)), for: .touchUpInside)
        optionDButton.addTarget(self, action: #selector(selectedOption(_:)), for: .touchUpInside)
    }
    
    @objc func selectedOption(_ sender: OptionButton){
        if let tag = OptionButtonTag(rawValue: sender.tag){
            switch tag {
            case OptionButtonTag.OptionA:
                let isCorrect = self.validateSelectedAnswer(selectedAnswer: "a")
                sender.setSelectedOptionVisibility(isVisible: false)
                optionBButton.resetButtonState()
                optionCButton.resetButtonState()
                optionDButton.resetButtonState()
                if isCorrect {
                    sender.setOptionBackgroundViewColor(with: Helper.Color.init().green)
                    sender.setSelectedOptionImage(with: UIImage(named: "correct")!)
                }else{
                    sender.setOptionBackgroundViewColor(with: Helper.Color.init().red)
                    sender.setSelectedOptionImage(with: UIImage(named: "wrong")!)
                }
            case OptionButtonTag.OptionB:
                let isCorrect = self.validateSelectedAnswer(selectedAnswer: "b")
            
                sender.setSelectedOptionVisibility(isVisible: false)
                optionAButton.resetButtonState()
                optionCButton.resetButtonState()
                optionDButton.resetButtonState()
                if isCorrect {
                    sender.setOptionBackgroundViewColor(with: Helper.Color.init().green)
                    sender.setSelectedOptionImage(with: UIImage(named: "correct")!)
                }else{
                    sender.setOptionBackgroundViewColor(with: Helper.Color.init().red)
                    sender.setSelectedOptionImage(with: UIImage(named: "wrong")!)
                }
            case OptionButtonTag.OptionC:
                let isCorrect = self.validateSelectedAnswer(selectedAnswer: "c")
                
                sender.setSelectedOptionVisibility(isVisible: false)
                optionAButton.resetButtonState()
                optionBButton.resetButtonState()
                optionDButton.resetButtonState()
                if isCorrect {
                    
                    sender.setOptionBackgroundViewColor(with: Helper.Color.init().green)
                    sender.setSelectedOptionImage(with: UIImage(named: "correct")!)
                }else{
                    sender.setOptionBackgroundViewColor(with: Helper.Color.init().red)
                    sender.setSelectedOptionImage(with: UIImage(named: "wrong")!)
                }
            case OptionButtonTag.OptionD:
                let isCorrect = self.validateSelectedAnswer(selectedAnswer: "d")
                sender.setSelectedOptionVisibility(isVisible: false)
                optionAButton.resetButtonState()
                optionBButton.resetButtonState()
                optionCButton.resetButtonState()
                if isCorrect {
                    sender.setOptionBackgroundViewColor(with: Helper.Color.init().green)
                    sender.setSelectedOptionImage(with: UIImage(named: "correct")!)
                }else{
                    sender.setOptionBackgroundViewColor(with: Helper.Color.init().red)
                    sender.setSelectedOptionImage(with: UIImage(named: "wrong")!)
                }
            }
            
        }
    }
    
    private func validateSelectedAnswer(selectedAnswer: String) -> Bool{
        if selectedAnswer == currentQuestion.answer!{
            return true
        }else{
            return false
        }
    }
    
    private func setViewContraints(){
        
        backgroundView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaLayoutGuide.snp.margins).inset(16)
            } else {
                make.edges.equalToSuperview().inset(16)
            }
        }
        
        questionImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(questionImageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        optionAButton.snp.makeConstraints { (make) in
            make.top.equalTo(questionLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        optionBButton.snp.makeConstraints { (make) in
            make.top.equalTo(optionAButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        optionCButton.snp.makeConstraints { (make) in
            make.top.equalTo(optionBButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        optionDButton.snp.makeConstraints { (make) in
            make.top.equalTo(optionCButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
    }
    private func setupQuestionViews(){
        //question image
        if let questionImage = currentQuestion.image {
            questionImageView.image = UIImage(data: questionImage)
            questionImageView.isHidden = false
        }
        //question
        if let questionText = currentQuestion.quesiton {
            questionLabel.text = questionText
        }
        
        //question option A
        if let option = currentQuestion.option {
            let optionAViewModel: OptionViewModel = OptionViewModel(option: "A", optionAnswer: option.optionA!)
            optionAButton.configure(with: optionAViewModel)
        }
        
        
        //question option B
        if let option = currentQuestion.option {
            let optionBViewModel: OptionViewModel = OptionViewModel(option: "B", optionAnswer: option.optionB!)
            optionBButton.configure(with: optionBViewModel)
        }
        
        
        //question option C
        if let option = currentQuestion.option {
            let optionCViewModel: OptionViewModel = OptionViewModel(option: "C", optionAnswer: option.optionC!)
            optionCButton.configure(with: optionCViewModel)
        }
        
        
        //question option D
        if let option = currentQuestion.option {
            let optionDViewModel: OptionViewModel = OptionViewModel(option: "D", optionAnswer: option.optionD!)
            optionDButton.configure(with: optionDViewModel)
        }
        
        
        
    }
    
    
}
