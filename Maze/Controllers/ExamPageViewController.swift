//
//  ExamPageViewController.swift
//  Maze
//
//  Created by Ismail on 12/04/2021.
//

import UIKit
import CoreData
import Firebase

class ExamPageViewController: UIPageViewController {
    
    var dataController: DataController!
    var firestoreDb: Firestore!
    var questions:[Question] = []
    var questionViewControllers = [UIViewController]()
    var pageNumber = 1
    let passMark = 10
    var hasPassed: Bool!
    var score: String!
    var totalScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(uploadScore))
        setupFetchRequest()
        
        if let subject =  UserDefaultManager.shared.getSubject()  {
            title = subject
        }
        for question in questions {
            let viewController = ExamViewController(with: question, dataController: dataController)
            questionViewControllers.append(viewController)
        }
        setupPageViewController()
        
        
    }
    
    @objc private func uploadScore(){
        showInfoAlert(message: "Uploading your score now will terminate any ongoing exam. Are you sure you want to go ahead?"){
            
            guard let question = self.questions.first else {
                return
            }
            self.calculateScore()
            let examData: [String : Any] = [
                "exam": question.examType as Any,
                "score": "\((self.totalScore/self.questions.count) * 100)%",
                "year": question.examYear as Any,
                "subject": UserDefaultManager.shared.getSubject()!
            ]
            
            self.firestoreDb.collection("history").addDocument(data: examData) { (error) in
                if let error = error {
                    self.showErrorAlert(message: error.localizedDescription)
                } else {
                    self.deleteSavedQuestions()
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
        
    }
    private func setupPageViewController(){
        guard let first = questionViewControllers.first else {
            return
        }
        
        self.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        dataSource = self
        delegate = self
    }
    private func setupFetchRequest() {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Question")
        
        do {
            questions = try dataController.viewContext.fetch(fetchRequest) as! [Question]
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}

extension ExamPageViewController : UIPageViewControllerDelegate{
    
}

extension ExamPageViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = questionViewControllers.firstIndex(of: viewController), index > 0 else {
            UserDefaultManager.shared.saveCurrentPage(0)
            return nil
        }
        
        let before = index - 1
        UserDefaultManager.shared.saveCurrentPage(before)
        return questionViewControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = questionViewControllers.firstIndex(of: viewController), index < (questionViewControllers.count - 1) else {
            UserDefaultManager.shared.saveCurrentPage((questionViewControllers.count - 1))
            navigateTo()
            return nil
        }
        
        let after = index + 1
        UserDefaultManager.shared.saveCurrentPage(after)
        return questionViewControllers[after]
    }
    
    func navigateTo() {
        calculateScore()
        
        let alertViewController = AlertService().alert(score: score, hasPassed: hasPassed){ viewId in
            
            if viewId == 1{
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AnswerVC") as! AnswerViewController
                viewController.dataController = self.dataController
                self.navigationController?.pushViewController(viewController, animated: true)
            }else if viewId == 2 {
                self.resetQuestions()
                self.navigationController?.popViewController(animated: true)
            }else if viewId == 3{
                self.deleteSavedQuestions()
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        present(alertViewController, animated: true)
        
    }
    
    func calculateScore() {
        totalScore = questions.filter{question in
            question.answer == question.selectedAnswer
        }.count
        score = "\(totalScore)/\(questions.count)"
        hasPassed = totalScore >= passMark
    }
    
    
    func deleteSavedQuestions(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Question")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try dataController.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: dataController.viewContext)
        } catch let error as NSError {
            showErrorAlert(message: error.localizedDescription)
        }
    }
    
    func resetQuestions(){
        for question in questions {
            if let selectedAnswer = question.selectedAnswer, !selectedAnswer.isEmpty {
                question.selectedAnswer = ""
                try? dataController.viewContext.save()
            }
        }
    }
}
