//
//  ViewController.swift
//  my-hood
//
//  Created by Mengying Feng on 4/02/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

//    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
//        // sample data
//        for i in 1...3 {
//            let post = Post(imagePath: "", title: "Post \(i)", description: "Post \(i) description")
//            posts.append(post)
//        }
//
//        tableView.reloadData()
        
        // initially load the posts
        DataService.instance.loadPosts()
        
        // get data from the NSNotificationCenter to load posts
        //this is the receiver ( or a listener)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
        
    }
    
    func onPostsLoaded(notif: AnyObject) {
        tableView.reloadData()
    }

    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get data from the singleton class: DataService
        let post = DataService.instance.loadedPosts[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostTableViewCell {
            cell.configureCell(post)
            return cell
        } else {
            let cell = PostTableViewCell()
            cell.configureCell(post)
            return cell
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // get data from the singleton class: DataService
        return DataService.instance.loadedPosts.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }


}

