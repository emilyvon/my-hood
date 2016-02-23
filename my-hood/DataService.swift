//
//  DataService.swift
//  my-hood
//
//  Created by Mengying Feng on 6/02/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    let KEY_POSTS = "posts"
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    func savePosts() {
        // 1. convert posts to data
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        // 2. save converted data
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadPosts() {
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        
        // after posts are loaded, we notify others who display the posts 
        // send a notification to the receiver
        NSNotificationCenter.defaultCenter().postNotificationName("postsLoaded", object: nil)
    }
    
    func saveImageAndCreatePath(image: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(image)
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathForFileName(imgPath)
        imgData?.writeToFile(fullPath, atomically: true)
        return imgPath
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        // refresh
        loadPosts()
    }
    
    //images are saved in your personal document directory, not NSUserDefault
    // passing the name of the image (name: String, e.g. myPic.png)
    func documentsPathForFileName(name: String) -> String {
        // get the path of your personal document directory (e.g. /User/...)
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        print(paths)
        let fullPath = paths[0] as NSString
        print(fullPath)
        // append your image name to the document directory path
        // we use NSString here because NSString has the method stirngByAppendingPathComponent()
        print(fullPath.stringByAppendingPathComponent(name))
        return fullPath.stringByAppendingPathComponent(name)
        
    }
}