//
//  MainViewController.swift
//  RMSwiftTest
//
//  Created by Rodrigo Mulkey on 6/4/14.
//  Copyright (c) 2014 Rodrigo Mulkey. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var menuItems: String[] = ["Reddit", "Twitter", "RSS", "Flickr"]
    var item = NSString []()
    var titleLabel: UILabel!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Main View Loaded")
        
        menuItems = ["Reddit", "Twitter", "RSS", "Flickr"]
        println(menuItems)
        
        titleLabel = UILabel(frame: CGRectMake(100, 50, 200, 50))
        titleLabel.text = "Select an API"
        view.addSubview(self.titleLabel)
    
        tableView = UITableView(frame: CGRectMake(0, 100, self.view.bounds.width-10, self.view.bounds.height-10), style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "mainMenu")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(self.tableView)
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        //println("Menu items count: " + self.menuItems.count)
        return self.menuItems.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("mainMenu", forIndexPath: indexPath) as UITableViewCell
        cell.text = self.menuItems[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    
        let redditVC: UIViewController = UIViewController(nibName:"RedditViewController", bundle: nil)
        self.presentViewController(redditVC, animated:true, completion:nil)
        
               
        
        //self.presentModalViewController(redditVC.self, animated: true)
        
//        let storyboard : UIStoryboard = UIStoryboard(name: "myTabBarName", bundle: nil);
//        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("myVCID") as UIViewController;
//        self.presentViewController(vc, animated: true, completion: nil);
        
    }
    
    
}
