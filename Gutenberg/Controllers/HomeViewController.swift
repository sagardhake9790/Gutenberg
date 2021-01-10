//
//  HomeViewController.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var appNameLbl: UILabel!
    @IBOutlet weak var appDescriptionLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var bookCategoryList: [BookCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setUpNavigationBar(title: "Home", isShowBackButton: false)
        
        self.appNameLbl.text = NSLocalizedString("HOME_VIEW_APP_NAME", comment: "")
        self.appNameLbl.font = Font.heading1Style
        self.appNameLbl.textColor = Color.primaryAppColor

        self.appDescriptionLbl.text = NSLocalizedString("PROJECT_DESCRIPTION", comment: "")
        self.appDescriptionLbl.font = Font.semiBoldLargeFontStyle
        self.appDescriptionLbl.textColor = Color.gray3Color
        
        self.bookCategoryList.append(BookCategory(category: "Fiction", image: "Fiction"))
        self.bookCategoryList.append(BookCategory(category: "Drama", image: "Drama"))
        self.bookCategoryList.append(BookCategory(category: "Humor", image: "Humour"))
        self.bookCategoryList.append(BookCategory(category: "Politics", image: "Politics"))
        self.bookCategoryList.append(BookCategory(category: "Phylosophy", image: "Philosophy"))
        self.bookCategoryList.append(BookCategory(category: "History", image: "History"))
        self.bookCategoryList.append(BookCategory(category: "Adventure", image: "Adventure"))
        
        tableView.register(UINib(nibName: "BookCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "BookCategoryTableViewCell")
    }
    
    //MARK: Table View Datasource & Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.bookCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCategoryTableViewCell", for: indexPath) as! BookCategoryTableViewCell
        
        let bookCategory = self.bookCategoryList[indexPath.row]
        
        cell.categoryLbl.text = bookCategory.category.uppercased()
        cell.categoryLbl.font = Font.semiBoldMediumFontStyle
        cell.categoryImageView.image = UIImage(named: bookCategory.image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBookCategory = self.bookCategoryList[indexPath.row]
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let booksListViewController = mainStoryboard.instantiateViewController(withIdentifier: "BooksListViewController") as! BooksListViewController
        booksListViewController.selectedBookCategory = selectedBookCategory
        self.navigationController?.pushViewController(booksListViewController, animated: true)
    }
}
