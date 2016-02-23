//
//  PostTableViewCell.swift
//  my-hood
//
//  Created by Mengying Feng on 4/02/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        postImg.image = DataService.instance.imageForPath(post.imagePath)
        titleLbl.text = post.title
        descLbl.text = post.postDesc
        
    }

}
