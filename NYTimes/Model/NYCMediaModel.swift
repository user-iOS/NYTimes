//
//  NYCMediaModel.swift
//  NYCAssessment
//
//  Created by Paurush on 29/06/19.
//  Copyright © 2019 Paurush. All rights reserved.
//

import Foundation

class NYCMediaModel {
    var type = ""
    var subType = ""
    var caption = ""
    var copyright = ""
    var approved_for_syndication = 0
    var media_metadata = [NYCMediaMetaDataModel]()
    
    init(json: [String : Any]) {
        if let type = json["type"] as? String {
            self.type = type
        }
        if let subType = json["subType"] as? String {
            self.subType = subType
        }
        if let caption = json["caption"] as? String {
            self.caption = caption
        }
        if let copyright = json["copyright"] as? String {
            self.copyright = copyright
        }
        if let approved_for_syndication = json["approved_for_syndication"] as? Int {
            self.approved_for_syndication = approved_for_syndication
        }
        if let media_metadata = json["media-metadata"] as? [[String : Any]] {
            self.media_metadata = media_metadata.map({ (mediaDataJson) -> NYCMediaMetaDataModel in
                return NYCMediaMetaDataModel(json: mediaDataJson)
            })
        }
    }
}

class NYCMediaMetaDataModel {
    var url = ""
    var format = ""
    var height = 0
    var width = 0
    
    init(json: [String : Any]) {
        if let url = json["url"] as? String {
            self.url = url
        }
        if let format = json["format"] as? String {
            self.format = format
        }
        if let height = json["height"] as? Int {
            self.height = height
        }
        if let width = json["width"] as? Int {
            self.width = width
        }
    }
}
