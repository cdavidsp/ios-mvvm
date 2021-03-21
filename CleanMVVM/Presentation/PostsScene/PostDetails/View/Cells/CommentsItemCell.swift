//
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import UIKit

final class CommentsItemCell: UITableViewCell {
    static let height = CGFloat(180)
    static let reuseIdentifier = String(describing: CommentsItemCell.self)

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func fill(with comment: CommentsItemViewModel) {
        
        self.nameLabel.text = comment.name
        self.bodyLabel.text = comment.body
        self.emailLabel.text = comment.email
    }
}
