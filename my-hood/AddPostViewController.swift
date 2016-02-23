//
//  AddPostViewController.swift
//  my-hood
//
//  Created by Mengying Feng on 5/02/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImage.layer.cornerRadius = postImage.frame.size.width / 2
        
        postImage.clipsToBounds = true
        
        //initiallize image picker
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
    }
    
    // MARK: Actions
    @IBAction func makePostButtonPressed(sender: AnyObject) {
        // 1. get the data from the fields
        if let title = titleField.text, let desc = descField.text, let img = postImage.image {
            
            let imgPath = DataService.instance.saveImageAndCreatePath(img)
            // 2. create a Post and save the data
            var post = Post(imagePath: "", title: title, description: desc)
            // 3. add posts to the dataservice(array), save posts, load posts
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addPicButtonPressed(sender: UIButton!) {
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: ImagePIcker delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImage.image = image
        
        
    }
}
