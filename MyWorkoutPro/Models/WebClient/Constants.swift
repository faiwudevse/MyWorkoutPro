//
//  Constants.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 12/7/17.
//  Copyright © 2017 Fai Wu. All rights reserved.
//

extension Client{
    struct Constants{
        static let ApiScheme = "https"
        static let Host = "myworkoutpro.firebaseio.com"
        static let Format = "json"
    }
    
    struct JSONBodyKeys{
        static let WebFeed = "webfeed"
        static let Description = "description"
        static let ImageURL = "imageURL"
        static let URL = "url"
    }
}
