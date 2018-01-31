//
//  WebFeedViewController.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 12/2/17.
//  Copyright © 2017 Fai Wu. All rights reserved.
//

import UIKit

class WebFeedTableViewController: UIViewController {
    
    // MARK: Outlooks
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    // Create a scroll down refresh controller
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        //refreshControl.tintColor = UIColor.red
        return refreshControl
    } ()
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    // MARK: SetLoadingScreen
    func setLoadingScreen() {
        // configure the loading view and activity indicator
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        self.view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        self.view.addConstraint(verticalConstraint)
        activityIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Feed"
        self.tableView.addSubview(self.refreshControl)
        loadWebFeedData()
        self.tableView.tableFooterView = UIView()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadWebFeedData(false)
        refreshControl.endRefreshing()
    }
    
    // Load the data from firebase
    func loadWebFeedData(_ showAtivityIndicator: Bool = true){
        if Reachability.isConnectedToNetwork() {
            if showAtivityIndicator {
                setLoadingScreen()
            }
            Client.sharedInstance().getWebFeed(){ (result,error) in
                if (result){
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }else{
            displayError("", "No Internet Connection")
        }
    }
}
// MAKR: table layout
extension WebFeedTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Client.sharedInstance().webFeedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let webFeedData = Client.sharedInstance().webFeedData
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! WebFeedTableViewCell
        let website = webFeedData[(indexPath as NSIndexPath).row]
        tableCell.cellText.text = website.description
        tableCell.cellImage?.contentMode = .scaleAspectFit
        tableCell.cellImage.image = UIImage(data: website.imageData!)
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webFeedData = Client.sharedInstance().webFeedData
        let url = webFeedData[(indexPath as NSIndexPath).row].url
        if let url = URL(string: url){
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else {
                displayError("", "Invalid URL")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//extension WebFeedTableViewController {
//    func displayError(_ title:String, _ error:String){
//        let alertView = UIAlertController(title: title, message: nil, preferredStyle: .alert)
//        alertView.addAction(UIAlertAction(title: "Dismiss", style: .`default`, handler: nil))
//        let messageFont = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: 15.0)!]
//        let messageAttrString = NSMutableAttributedString(string: error, attributes: messageFont)
//        alertView.setValue(messageAttrString, forKey: "attributedMessage")
//        self.present(alertView, animated: true, completion: nil)
//    }
//}


