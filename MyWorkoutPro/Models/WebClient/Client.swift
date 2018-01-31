//
//  Client.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 12/7/17.
//  Copyright © 2017 Fai Wu. All rights reserved.
//

import Foundation
import UIKit
class Client: NSObject {
    
    // MARK: Properties
    var session = URLSession.shared
    var webFeedData : [WebFeed] = []
    let stack = (UIApplication.shared.delegate as! AppDelegate).stack
    
    func taskForGetMethod(_ object: String, _ completionHandlerForGet: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionTask {
        let urlRequest = NSMutableURLRequest(url: formURL(object))
        
        let task = session.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForGet(nil, NSError(domain:"taskForGetMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            self.convertDataWithCompletionHandler(data, completionHandlerForGet)
        }
        
        task.resume()
        return task
    }
    
    private func convertDataWithCompletionHandler(_ data: Data, _ completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void){
        var parsedResultData: AnyObject!
        
        do{
            parsedResultData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch{
            let userInfo = [NSLocalizedDescriptionKey: "Could not parse the data as JSON '\(data)'"]
            completionHandlerForConvertData(nil,  NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResultData, nil)
    }
    
    private func formURL(_ object: String) -> URL {
        var components = URLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.Host
        components.path = "/" + object + "." + Constants.Format
        return components.url!
    }
    class func sharedInstance() -> Client {
        struct Singleton {
            static var sharedInstance = Client()
        }
        return Singleton.sharedInstance
    }
    func preloadData(){
        // Remove previous stuff (if any)
        do {
            try stack.dropAllData()
        } catch {
            print("Error droping all objects in DB")
        }
        if let contentsOfURL = Bundle.main.url(forResource: "exercisesdata", withExtension: "csv"){
            if let items = parseCSV(contentsOfURL: contentsOfURL){
                for item in items{
                    _ = Exercise(distance: item.distance, duration: item.duration, name: item.name, resistance: item.resistance, type: Int16(item.type), weight: item.weight, context: stack.context)
                }
            }
        }
        stack.save()
    }
    private func parseCSV(contentsOfURL: URL) -> [(name:String, distance:Bool, duration: Bool, resistance: Bool, weight:Bool, type: Int )]? {
        let delimiter = ","
        var items: [(name: String, distance: Bool, duration: Bool, resistance: Bool, weight: Bool, type: Int)]?
        do{
            let content = try String(contentsOf: contentsOfURL)
            items = []
            let lines: [String] = content.components(separatedBy: NSCharacterSet.newlines) as [String]
            for line in lines {
                var values: [String] = []
                var textToScan:String = line
                var value:NSString?
                var textScanner:Scanner = Scanner(string: textToScan)
                while textScanner.string != "" {
                    if (textScanner.string as NSString).substring(to: 1) == "\"" {
                        textScanner.scanLocation += 1
                        textScanner.scanUpTo("\"", into: &value)
                        textScanner.scanLocation += 1
                    } else {
                        textScanner.scanUpTo(delimiter, into: &value)
                        
                    }
                    
                    // Store the value into the values array
                    values.append(value! as String)
                    
                    // Retrieve the unscanned remainder of the string
                    if textScanner.scanLocation < textScanner.string.count {
                        textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                    } else {
                        textToScan = ""
                    }
                    textScanner = Scanner(string: textToScan)
                }
                if values.count > 0 {
                    let item = (name:values[0], distance: values[1] == "1" ? true: false, duration: values[2] == "1" ? true: false, resistance:  values[3] == "1" ? true: false, weight: values[4] == "1" ? true: false, type: Int(values[5])!)
                    items?.append(item)
                }
            }
        } catch {
            print("Error in parseCSV function")
        }
        
        return items
    }
}
