//
//  Helper.swift
//  Maze
//
//  Created by Ismail on 14/04/2021.
//

import Foundation
import UIKit

//MARK: Helper class for static data
class Helper{
    
    private static let mapper: [String: String] = ["English language":"English",
                                                   "English literature":"Englishlit",
                                                   "Christian Religious Knowledge":"CRK",
                                                   "Islamic Religious Knowledge":"IRK",
                                                   "Civic Education":"Civiledu",
                                                   "Current Affairs":"Currentaffairs"]
    static func getExamTypes() -> [String]{
        return ["UTME", "Post-UTME", "WASSCE"]
    }
    
    static func getExamYears() -> [String]{
        return ["2001", "2002", "2003", "2004", "2005", "2006",
                "2007", "2008", "2009", "2010", "2011", "2012",
                "2013"]
    }
    
    static func getExamSubjects() -> [String]{
        return ["English language", "Mathematics", "Commerce",
                "Accounting", "Biology", "Physics",
                "Chemistry", "English literature", "Government",
                "Christian Religious Knowledge", "Geography", "Economics",
                "Islamic Religious Knowledge", "Civil Education", "Insurance",
                "Current Affairs", "History"]
    }
    
    static func formatSubject(from subject: String) -> String{
        if let mappedSubject = mapper[subject] {
            return mappedSubject
        }
        return subject
    }
    
    struct Color {
        static let black = UIColor(hex: "#333333FF")!
        static let borderGray = UIColor(hex: "#F2F2F2FF")!
        static let backgroundGray = UIColor(hex: "#E0E0E0FF")!
        static let green = UIColor(hex: "#64BC26FF")!
        static let red = UIColor(hex: "#EA1601FF")!
        static let backgroundGreen = UIColor(hex: "#F4FAF9FF")!
        static let alertGreen = UIColor(hex: "#4FB5A4FF")!
        static let alertRed = UIColor(hex: "#E79B9BFF")!
    }
}

//MARK: View Tags
enum PickerTag:Int{
    case ExamTypePicker
    case ExamSubjectPicker
    case ExamYearPicker
}

enum OptionButtonTag:Int{
    case OptionA
    case OptionB
    case OptionC
    case OptionD
}
