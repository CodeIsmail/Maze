//
//  QuestionResponse.swift
//  Maze
//
//  Created by Ismail on 10/04/2021.
//

import Foundation

// MARK: - QuestionResponse
struct QuestionResponse: Codable {
    let subject: String
    let status: Int
    let data: [ExamQuestion]
}

// MARK: - Data
struct ExamQuestion: Codable {
    let id: Int
    let question: String
    let option: QuestionOption
    let section, image, answer, solution: String
    let examtype, examyear: String
}

// MARK: - Option
struct QuestionOption: Codable {
    let optionA, optionB, optionC, optionD: String
    
    enum CodingKeys: String, CodingKey{
        case optionA =  "a"
        case optionB = "b"
        case optionC = "c"
        case optionD = "d"
    }
}
