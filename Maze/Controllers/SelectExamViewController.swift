//
//  ViewController.swift
//  Maze
//
//  Created by Ismail on 09/04/2021.
//

import UIKit
import CoreData

class SelectExamViewController: UIViewController {

    @IBOutlet weak var examTypeTextField: UITextField!
    @IBOutlet weak var examSubjectTextField: UITextField!
    @IBOutlet weak var examYearTextField: UITextField!
    @IBOutlet weak var viewQuestionsButton: UIButton!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    var dataController: DataController!
    let examTypes: [String] = Helper.getExamTypes()
    let examSubjects: [String] = Helper.getExamSubjects()
    let examYears: [String] = Helper.getExamYears()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewQuestionsButton.isEnabled = false

        ConfigurePickers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFetchRequest()
    }

    func ConfigurePickers() {
        let examTypePicker = UIPickerView()
        examTypePicker.tag = PickerTag.ExamTypePicker.rawValue
        examTypePicker.dataSource = self
        examTypePicker.delegate = self
        examTypeTextField.inputView = examTypePicker
        
        let examSubjectPicker = UIPickerView()
        examSubjectPicker.tag = PickerTag.ExamSubjectPicker.rawValue
        examSubjectPicker.dataSource = self
        examSubjectPicker.delegate = self
        examSubjectTextField.inputView = examSubjectPicker
        
        let examYearPicker = UIPickerView()
        examYearPicker.tag = PickerTag.ExamYearPicker.rawValue
        examYearPicker.dataSource = self
        examYearPicker.delegate = self
        examYearTextField.inputView = examYearPicker
        
    }

    @IBAction func viewQuestions(_ sender: Any) {
        
        let examType = examTypeTextField.text!
        let examYear = examYearTextField.text!
        let examSubject = Helper.formatSubject(from: examSubjectTextField.text!)
        
        updateLoadingState(isLoading: true)
        ApiClient.taskRequestExamQuestions(examType: examType, subject: examSubject, year: examYear) { (questions, error) in
            self.updateLoadingState(isLoading: false)
            
            guard error == nil else {
                
                //TODO: Display a error dialog
                return
            }
            
            for question in questions{
                
                let option = Option(context: self.dataController.viewContext)
                option.optionA = question.option.optionA
                option.optionB = question.option.optionB
                option.optionC = question.option.optionC
                option.optionD = question.option.optionD
                
                let questionDb = Question(context: self.dataController.viewContext)
                questionDb.answer = question.answer
                questionDb.examType = question.examtype
                questionDb.examYear = question.examyear
                questionDb.imageUrl = question.image
                questionDb.quesiton = question.question
                questionDb.section = question.section
                questionDb.option = option
                
                try? self.dataController.viewContext.save()
            }
            self.navigateToQuestionPage()
            
        }
    }
    private func setupFetchRequest() {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Question")
        
        do {
            let questions = try dataController.viewContext.fetch(fetchRequest) as! [Question]
            
            if !questions.isEmpty {
                navigateToQuestionPage()
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func navigateToQuestionPage() {
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ExamPage") as! ExamPageViewController
        viewController.dataController = dataController
            
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func updateLoadingState(isLoading: Bool) {
        if isLoading {
            progressIndicator.startAnimating()
        }else{
            progressIndicator.stopAnimating()
        }
        examTypeTextField.isEnabled =  !isLoading
        examSubjectTextField.isEnabled =  !isLoading
        examYearTextField.isEnabled =  !isLoading
        viewQuestionsButton.isEnabled =  !isLoading
    }
    
    func updateUIState() {
        guard let examTypeText = examTypeTextField.text else {
            viewQuestionsButton.isEnabled = false
            return
        }
        guard let examSubjectText = examSubjectTextField.text else {
            viewQuestionsButton.isEnabled = false
            return
        }
        guard let examYearText = examYearTextField.text else {
            viewQuestionsButton.isEnabled = false
            return
        }
        
        if !examTypeText.isEmpty && !examSubjectText.isEmpty && !examYearText.isEmpty {
            viewQuestionsButton.isEnabled = true
        }else{
            viewQuestionsButton.isEnabled = false
        }
    }
}

extension SelectExamViewController : UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var rowCount: Int = 0

        if let tag = PickerTag.init(rawValue: pickerView.tag){
            switch tag {
            case PickerTag.ExamTypePicker:
                rowCount =  examTypes.count
            case PickerTag.ExamSubjectPicker:
                rowCount = examSubjects.count
            case PickerTag.ExamYearPicker:
                rowCount =  examYears.count
            }
        }
        return rowCount
    }
}

extension SelectExamViewController : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let tag = PickerTag.init(rawValue: pickerView.tag){
            switch tag {
            case PickerTag.ExamTypePicker:
                examTypeTextField.text = examTypes[row]
                examTypeTextField.resignFirstResponder()
            case PickerTag.ExamSubjectPicker:
                examSubjectTextField.text = examSubjects[row]
                examSubjectTextField.resignFirstResponder()
            case PickerTag.ExamYearPicker:
                examYearTextField.text = examYears[row]
                examYearTextField.resignFirstResponder()
            }
        }
        updateUIState()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return examTypes[row]
        }else if pickerView.tag  == 1{
            return examSubjects[row]
        }else{
            return examYears[row]
        }
    }
}

