//
//  BookCategoryTableViewCell.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import UIKit

class BookCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardView.layer.cornerRadius = 4.0
        self.cardView.layer.shadowColor = UIColor.gray.cgColor
        self.cardView.layer.shadowOffset = CGSize(width: 2.0, height: 5.0)
        self.cardView.layer.shadowRadius = 1.0
        self.cardView.layer.shadowOpacity = 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
