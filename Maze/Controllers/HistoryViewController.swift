//
//  HistoryViewController.swift
//  Maze
//
//  Created by Ismail on 11/04/2021.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    var firestoreDb: Firestore!
    var examHistories:[History] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firestoreDb.collection("history").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let historyDict = document.data()
                    let subject = historyDict["subject"] as! String
                    let year = historyDict["year"] as! String
                    let score = historyDict["score"] as! String
                    let examType = historyDict["exam"] as! String
                    
                    self.examHistories.append(History(subject: subject, year: year, examType: examType, score: score))
                }
                self.historyTableView.reloadData()
            }
        }
       
    }
}

extension HistoryViewController: UITableViewDelegate{
    
}

extension HistoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        examHistories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as!
        HistoryTableViewCell
        
        let history = examHistories[indexPath.row]
        
        cell.subjectLabel.text = history.subject
        cell.scoreLabel.text = history.score
        cell.examTypeLabel.text = history.examType
        cell.creationDateLabel.text = history.year
        
        return cell
    }
    
    
}
