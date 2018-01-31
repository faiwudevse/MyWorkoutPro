//
//  ClientConvenience.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 12/8/17.
//  Copyright © 2017 Fai Wu. All rights reserved.
//

import Foundation

extension Client{
    func getWebFeed(_ completionHandlerforWebFeed: @escaping(_ sucess: Bool, _ error: NSError?) -> Void) {
        let _ = taskForGetMethod(JSONBodyKeys.WebFeed) { (results, error) in
            
            if let error = error {
                completionHandlerforWebFeed(false, error)
            }else{
                if let results = results as? NSDictionary{
                    let webFeedDataInfo = WebFeed.webFeedFromResults(results)
                    self.webFeedData.removeAll()
                    self.webFeedData = webFeedDataInfo
                    completionHandlerforWebFeed(true, nil)
                }
                else{
                    self.errorCanNotbeFoundMessage(JSONBodyKeys.WebFeed, results!)
                    completionHandlerforWebFeed(false, NSError(domain: "getWebFeed", code: 0, userInfo: [NSLocalizedDescriptionKey: ""]))
                }
            }
        }
    }
    
    func downloadImage( _ url: String, _ completionHandlerForDownloadImage: @escaping(_ data: Data? , _ error: NSError?) -> Void) {
        let imageURL = URL(string: url)
        if let imaageData = try? Data(contentsOf: imageURL!) {
            completionHandlerForDownloadImage(imaageData,nil)
        }else{
            completionHandlerForDownloadImage(nil, NSError(domain: "dowloadImage", code: 1, userInfo: [NSLocalizedDescriptionKey: "Image does not exist at \(url)"]))
        }
    }
    
    func errorCanNotbeFoundMessage(_ key:String, _ result: AnyObject) -> Void{
        print("Cannnot find \(key) in \(result)")
    }
}
