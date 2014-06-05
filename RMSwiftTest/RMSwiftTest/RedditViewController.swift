//
//  RedditViewController.swift
//  RMSwiftTest
//
//  Created by Rodrigo Mulkey on 6/5/14.
//  Copyright (c) 2014 Rodrigo Mulkey. All rights reserved.
//

import UIKit
    
    class RedditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
        var tableView: UITableView!
        var redditThreads = NSString[]()
        var redditThreadsData: NSArray = NSArray()
        var data: NSMutableData!
        
        init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: UITableViewStyle.Plain)
            self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "redditThread")
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.view.addSubview(self.tableView)
            self.refreshRedditData()
        }
        
        func refreshRedditData(){
            var url: NSURL = NSURL(string: "http://reddit.com/r/swift.json")
            var request: NSURLRequest = NSURLRequest(URL: url)
            var connection: NSURLConnection = NSURLConnection(request: request, delegate:self, startImmediately: false)
            connection.start()
        }
        
        // connection delegate
        func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
            // Recieved a new request, clear out the data object
            self.data = NSMutableData()
        }
        
        func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
            // Append the recieved chunk of data to our data object
            self.data.appendData(data)
        }
        
        func connectionDidFinishLoading(connection: NSURLConnection!) {
            var err: NSError
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            
            if(jsonResult["data"].count > 0){
                var data: NSDictionary = jsonResult["data"] as NSDictionary
                if(data["children"].count > 0){
                    self.redditThreadsData = data["children"] as NSArray
                    //                for child: Dictionary<String, AnyObject> in self.redditThreadsData {
                    for var i = 0; i < self.redditThreadsData.count; ++i {
                        var child: Dictionary<String, AnyObject> = self.redditThreadsData[i] as (Dictionary<String, AnyObject>)
                        var threadInfo: NSDictionary = child["data"] as NSDictionary
                        var title: String = threadInfo["title"] as String
                        self.redditThreads.append(title)
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
            return self.redditThreads.count
        }
        
        func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("redditThread", forIndexPath: indexPath) as UITableViewCell
            cell.text = self.redditThreads[indexPath.row]
            return cell
            
        }
}
