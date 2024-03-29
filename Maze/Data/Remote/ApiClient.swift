//
//  ApiClient.swift
//  Maze
//
//  Created by Ismail on 14/04/2021.
//

import Foundation

class ApiClient{
    
    struct ApiData {
        static var subject = ""
    }
    enum Endpoint {
        
        static let BaseUrl = "https://questions.aloc.com.ng/api/v2/q/20?"
        
        case requestExamQuestion(String, String, String)
        
        var stringValue: String{
            switch self {
            case .requestExamQuestion(let type, let subject, let year):
                return Endpoint.BaseUrl + "subject=\(subject)" + "&year=\(year)" + "&type=\(type)"
            
            }
        }
        
        var url: URLRequest{
            var request = URLRequest(url: URL(string: stringValue)!)
            
            request.addValue(ALOC_API_KEY, forHTTPHeaderField: "AccessToken")
            return request
        }
    }
    
    static func taskRequestExamQuestions(examType: String, subject: String, year: String, completion: @escaping (([ExamQuestion], Error?)->Void)) {
        ApiData.subject = subject;
        let task = URLSession.shared.dataTask(with: Endpoint.requestExamQuestion(examType, subject, year).url){
            data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion([], error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let response = try decoder.decode(QuestionResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(response.data, nil)
                }
            }catch{
                DispatchQueue.main.async {
                    completion([], error)
                }
            }
            
        }
        task.resume()
    }
    
    static func downloadImageRequest(question: Question, completion: @escaping ((Data?, Error?)->Void)) {
        let task = URLSession.shared.downloadTask(with: URL(string: question.imageUrl!)!){
            dataUrl, response, error in
            
            guard let dataUrl = dataUrl else {
                completion(nil, error)
                return
            }
            
            if let data = try? Data(contentsOf: dataUrl){
                completion(data, nil)
            }
            
        }
        task.resume()
    }
}
