//
//  ExamPageViewController.swift
//  Maze
//
//  Created by Ismail on 12/04/2021.
//

import UIKit
import CoreData

class ExamPageViewController: UIPageViewController {
    
    var dataController: DataController!
    var questions:[Question] = []
    var questionViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchRequest()
        for question in questions {
            let viewController = ExamViewController(with: question, dataController: dataController)
            questionViewControllers.append(viewController)
        }
        setupPageViewController()
        
        
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
            return nil
        }
        
        let after = index + 1
        UserDefaultManager.shared.saveCurrentPage(after)
        return questionViewControllers[after]
    }
    
    
}
