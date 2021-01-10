//
//  BookCollectionViewCell.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookAuthorLbl: UILabel!
    @IBOutlet weak var bookTitleLbl: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bookImageContainerView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookTitleLbl.font = Font.semiBoldSmallFontStyle
        bookTitleLbl.textColor = Color.gray3Color
        
        bookAuthorLbl.font = Font.semiBoldSmallFontStyle
        bookAuthorLbl.textColor = Color.gray2Color
        
        self.bookImageContainerView.layer.shadowColor = UIColor.gray.cgColor
        self.bookImageContainerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.bookImageContainerView.layer.shadowRadius = 1.0
        self.bookImageContainerView.layer.shadowOpacity = 0.5
        
        bookImageView.clipsToBounds = true
        bookImageView.layer.cornerRadius = 10
    }
}
