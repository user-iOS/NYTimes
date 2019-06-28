//
//  NYCViewModel.swift
//  NYCAssessment
//
//  Created by Paurush on 29/06/19.
//  Copyright © 2019 Paurush. All rights reserved.
//

import Foundation

let API_KEY = "LOi0UnAxXDyKKxL2yavEo2FEC3B31xwn"//"cb93bb547a22438c9e30577d0e84b221"
let strArticleUrl = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(API_KEY)"

class NYCViewModel {
    var nycModel = [NYCModel]()
    
    func requestForNYCArticles(completionHandler: @escaping(() -> ())) {
        if let url = URL(string: strArticleUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if let tempData = data {
                        do {
                            let jsonData = try JSONSerialization.jsonObject(with: tempData, options: .allowFragments)
                            if let json = jsonData as? [String : Any], let results = json["results"] as? [[String : Any]] {
                                self.nycModel = results.map({ (resultJson) -> NYCModel in
                                        return NYCModel(json: resultJson)
                                }).filter {
                                    $0.type.lowercased() == "article"
                                    }.sorted(by: { (model1, model2) -> Bool in
                                        return model1.originalDate > model2.originalDate
                                    })
                            }
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }
                completionHandler()
            }.resume()
        }
    }
}
