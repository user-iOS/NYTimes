//
//  NYCModel.swift
//  NYCAssessment
//
//  Created by Paurush on 29/06/19.
//  Copyright © 2019 Paurush. All rights reserved.
//

import Foundation

class NYCModel {
    var url = ""
    var adx_keywords = ""
    var column = ""
    var section = ""
    var byline = ""
    var type = ""
    var title = ""
    var abstract = ""
    var published_date = ""
    var originalDate = Date()
    var source = ""
    var id: Int64 = 0
    var asset_id: Int64 = 0
    var views = 0
    var des_facet = [String]()
    var org_facet = [String]()
    var per_facet = [String]()
    var geo_facet = [String]()
    var media = [NYCMediaModel]()
    
    init(json: [String : Any]) {
        if let url = json["url"] as? String {
            self.url = url
        }
        if let adx_keywords = json["adx_keywords"] as? String {
            self.adx_keywords = adx_keywords
        }
        if let column = json["column"] as? String {
            self.column = column
        }
        if let section = json["section"] as? String {
            self.section = section
        }
        if let byline = json["byline"] as? String {
            self.byline = byline
        }
        if let type = json["type"] as? String {
            self.type = type
        }
        if let title = json["title"] as? String {
            self.title = title
        }
        if let abstract = json["abstract"] as? String {
            self.abstract = abstract
        }
        if let published_date = json["published_date"] as? String {
            self.published_date = published_date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let convertedDate = formatter.date(from: published_date) {
                self.originalDate = convertedDate
            }
        }
        if let source = json["source"] as? String {
            self.source = source
        }
        if let id = json["id"] as? Int64 {
            self.id = id
        }
        if let asset_id = json["asset_id"] as? Int64 {
            self.asset_id = asset_id
        }
        if let views = json["views"] as? Int {
            self.views = views
        }
        if let des_facet = json["des_facet"] as? [String] {
            self.des_facet = des_facet
        }
        if let org_facet = json["org_facet"] as? [String] {
            self.org_facet = org_facet
        }
        if let per_facet = json["per_facet"] as? [String] {
            self.per_facet = per_facet
        }
        if let geo_facet = json["geo_facet"] as? [String] {
            self.geo_facet = geo_facet
        }
        if let media = json["media"] as? [[String : Any]] {
            self.media = media.map({ (mediaJson) -> NYCMediaModel in
                return NYCMediaModel(json: mediaJson)
            })
        }
    }
}
