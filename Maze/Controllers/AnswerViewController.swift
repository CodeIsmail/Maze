//
//  AnswerViewController.swift
//  Maze
//
//  Created by Ismail on 11/04/2021.
//

import UIKit
import CoreData

class AnswerViewController: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var answerTableView: UITableView!
    
    //MARK: Properties
    var dataController: DataController!
    var fetchResultController: NSFetchedResultsController<Question>!
    
    //MARK: DataSource
    override func viewDidLoad() {
        super.viewDidLoad()

        setupFetchResultController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchResultController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchResultController = nil
    }

    //MARK: Util Function
    private func setupFetchResultController() {
        let fetchRequest:NSFetchRequest<Question> = Question.fetchRequest()
        fetchRequest.sortDescriptors = []
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        do {
            try fetchResultController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
}

//MARK: DataSource
extension AnswerViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = fetchResultController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell")!

        // Configure cell
        if let selectedAnswer = question.selectedAnswer {
            cell.textLabel?.text = "\((indexPath.row + 1)).  \(selectedAnswer.uppercased())"
        }else{
            cell.textLabel?.text = "\((indexPath.row + 1)).  - "
        }
        
        return cell
    }
    
}

extension AnswerViewController: NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        answerTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        answerTableView.endUpdates()
    }
}
