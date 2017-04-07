//
//  ApiService.swift
//  Movies
//
//  Created by Alexandre Malkov on 29/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiServiceDelegate : class {
    func apiServiceDataReceived()
}

class ApiService {
    
    var useMockUpData = false
    
    weak var delegate: ApiServiceDelegate?
    
    init(delegate: ApiServiceDelegate) {
        self.delegate = delegate
    }
    
    func requestHomeData() {
        
        func responseHandler(response: DataResponse<Any>) {
            if let _ = response.result.value {
                
                // Delete old data
                Schedule.deleteAll()
                
                // Load new schedule data
                Schedule.loadFromJson(jsonData: response.data)
                
                // Call for Film updates
                for schedule in Schedule.getAll()! {
                    self.requestFilmData(film_uid: schedule.film_uid)
                }
                
                // Save changes
                DataController.saveContext()
                
                // Notify delegate
                self.delegate?.apiServiceDataReceived()
            }
        }
        
        if useMockUpData {
            let response = self.getResponseFromJsonFile("Home")
            responseHandler(response: response)
        } else {
            Alamofire.request("http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000/api/sets/?slug=home").responseJSON { response in
                responseHandler(response: response)
            }
        }
        
    }
    
    func requestFilmData(film_uid: String?) {
        if let film_uid = film_uid {
            
            func responseHandler(response: DataResponse<Any>) {
                if let _ = response.result.value {
                    Film.loadFromJson(jsonData: response.data)
                    self.delegate?.apiServiceDataReceived()
                }
            }
            
            if useMockUpData {
                let response = self.getResponseFromJsonFile(film_uid)
                responseHandler(response: response)
            } else {
                let url = "http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000/api/episodes/" + film_uid + "/"
                
                Alamofire.request(url).responseJSON { response in
                    responseHandler(response: response)
                }
            }
        }
    }
    
    private func getResponseFromJsonFile(_ fileName: String) -> DataResponse<Any> {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let jsonString = try String(contentsOfFile: filePath)
                let data = jsonString.data(using: .utf8)
                if let data = data {
                    return DataResponse(request: nil, response: nil, data: data, result: Result.success(data))
                }
            } catch let error {
                print("ERROR: \(error)")
            }
        }
        
        return DataResponse(request: nil, response: nil, data: Data(), result: Result.failure(AFError.invalidURL(url: fileName)))
    }
    
}
