//
//  ApiService.swift
//  Movies
//
//  Created by Alexandre Malkov on 29/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiServiceDelegate: class {
    func apiServiceDataReceived()
}

class ApiService {
    
    weak var delegate: ApiServiceDelegate?
    
    init(delegate: ApiServiceDelegate) {
        self.delegate = delegate
    }
    
    func requestHomeData() {
        
        Alamofire.request("http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000/api/sets/?slug=home").responseJSON { response in

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
    }
    
    func requestFilmData(film_uid: String?) {
        if film_uid != nil {
            let url = "http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000/api/episodes/" + film_uid! + "/"
            
            Alamofire.request(url).responseJSON { response in
                
                if let _ = response.result.value {
                    Film.loadFromJson(jsonData: response.data)
                    self.delegate?.apiServiceDataReceived()
                }
            }
        }
    }
    
}
