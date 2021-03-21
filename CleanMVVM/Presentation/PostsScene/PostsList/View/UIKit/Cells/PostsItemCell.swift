//
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021.
//

import UIKit

final class PostsItemCell: UITableViewCell {
    static let height = CGFloat(50)
    static let reuseIdentifier = String(describing: PostsItemCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func fill(with post: PostsListItemViewModel) {
        
        self.titleLabel.text = post.title
        self.bodyLabel.text = post.body
    }
}
