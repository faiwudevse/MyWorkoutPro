//
//  WebFeed.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 12/8/17.
//  Copyright © 2017 Fai Wu. All rights reserved.
//

import Foundation

struct WebFeed{
    let url: String
    let description: String
    var imageData: Data?
    
    init?(_ dictionary: [String: AnyObject]){
        
        if let urlKeyVal = dictionary[Client.JSONBodyKeys.URL] {
            url = urlKeyVal as! String
        } else{
            return nil
        }
        
        if let descriptionKeyVal = dictionary[Client.JSONBodyKeys.Description] {
            description = descriptionKeyVal as! String
        } else{
            return nil
        }
        
        if let imageURLKeyVal = dictionary[Client.JSONBodyKeys.ImageURL] {
            let imageURL = imageURLKeyVal as! String
            if let data = try? Data(contentsOf: URL(string: imageURL)!) {
                imageData = data
            }else{
                imageData = nil
            }
        } else{
            return nil
        }
        
    }
    
    static func webFeedFromResults(_ results: NSDictionary) -> [WebFeed] {
        
        var webFeedData : [WebFeed] = []
        
        for (_,value) in results {
            
            let webfeed = WebFeed((value as? [String:AnyObject])!)
            webFeedData.append(webfeed!)
        }
        return webFeedData
    }
}
