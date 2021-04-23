//
//  HistoryViewController.swift
//  Maze
//
//  Created by Ismail on 11/04/2021.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController {
    //MARK: Outlet
    @IBOutlet weak var historyTableView: UITableView!
    
    //MARK: Properties
    var firestoreDb: Firestore!
    var examHistories:[History] = []
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Maze"
        
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
    
    @IBAction func logoutTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            UserDefaultManager.shared.saveUser(nil)
            
            let loginViewController = ControllerHelper.getLoginViewController()
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginViewController)
        } catch let signOutError as NSError {
            showErrorAlert(message: "Error Signing out")
            print ("Error signing out: %@", signOutError)
        }
    }
}

//MARK: Delegate
extension HistoryViewController: UITableViewDelegate{
    
}

//MARK: DataSource
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
        cell.examYearLabel.text = history.year
        
        return cell
    }
    
    
}
