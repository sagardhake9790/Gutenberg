//
//  BooksListViewController.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import UIKit
import SDWebImage

class BooksListViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedBookCategory: BookCategory?
    var bookList: [Book] = []
    let bookListViewModel = BookListViewModel()
    var bookListServiceResponse: BookListServiceResponse?
    var showNextAvailableBooks = false
    var showSearchedTextBooks = false
    var searchedBookListServiceResponse: BookListServiceResponse?
    var searchBookList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpNavigationBar(title: selectedBookCategory?.category ?? "", isShowBackButton: true)
        
        if let textfield = self.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = Color.gray1Color
        }
                
        self.collectionView.register(UINib(nibName: "BookCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        if (!CheckNetwork.Connection())
        {
            self.showNoInternetConnectionAlert()
        }
        else
        {
            self.getSelectedCategoryBooks();
        }
    }
    
    //MARK: Network Calls
    
    func getSelectedCategoryBooks() {
        var url = ""
        
        if(self.showNextAvailableBooks)
        {
            guard let nextBookFetchUrl = self.bookListServiceResponse?.nextBookFetchUrl else {
                return
            }
            
            url = nextBookFetchUrl
        }
        else
        {
            url = String(format: Apis.getBooksByCategory, self.selectedBookCategory?.category ?? "")
        }
        
        self.showActivityIndicator(message: "Loading Books")

        self.bookListViewModel.fetchBookListByCaregory(url: url) { (bookListServiceResponse) in
            self.bookListServiceResponse = bookListServiceResponse
            
            if(self.showNextAvailableBooks)
            {
                self.bookList.append(contentsOf: bookListServiceResponse.books)
            }
            else
            {
                self.bookList = bookListServiceResponse.books
            }
            
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                self.collectionView.reloadData()
            }
        } failure: { (error) in
            print("Error occured in fetching data:- \(error)")
            self.hideActivityIndicator()
        }
    }
    
    func getBooksBasedOnSearchString() {
            
        var url = ""
        
        if(self.showNextAvailableBooks)
        {
            guard let nextBookFetchUrl = self.searchedBookListServiceResponse?.nextBookFetchUrl else {
                return
            }
            
            url = nextBookFetchUrl
        }
        else
        {
            url = String(format: Apis.getBooksBySearchString, self.selectedBookCategory?.category ?? "", self.searchBar.text ?? "")
        }
        self.showActivityIndicator(message: "Loading Books")

        self.bookListViewModel.fetchBookListByCaregory(url: url) { (bookListServiceResponse) in
            self.searchedBookListServiceResponse = bookListServiceResponse
        
            if(self.showNextAvailableBooks)
            {
                self.searchBookList.append(contentsOf: bookListServiceResponse.books)
            }
            else
            {
                self.searchBookList = bookListServiceResponse.books
            }
            DispatchQueue.main.async {
                self.showSearchedTextBooks = true
                self.hideActivityIndicator()
                self.collectionView.reloadData()
            }
        } failure: { (error) in
            print("Error occured in fetching data:- \(error)")
            self.hideActivityIndicator()
        }
    }
   
    //MARK: Collection View Datasource & Delegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.showSearchedTextBooks ? self.searchBookList.count : self.bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        
        let book = self.showSearchedTextBooks ? self.searchBookList[indexPath.item] : self.bookList[indexPath.item]
        
        cell.bookTitleLbl.text = book.title
        cell.bookAuthorLbl.text = book.authors[0].name
        
        let bookImageUrl = "https://www.gutenberg.org/cache/epub/\(book.id)/pg\(book.id).cover.medium.jpg"
        
        cell.bookImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.bookImageView.sd_setImage(with: URL(string: bookImageUrl), placeholderImage: UIImage(named: "placeholderImage"))


        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(self.showSearchedTextBooks)
        {
            if (indexPath.item == self.searchBookList.count - 1 ) {
                self.showNextAvailableBooks = true
                self.getBooksBasedOnSearchString()
            }
        }
        else
        {
            if (indexPath.item == self.bookList.count - 1 ) {
                self.showNextAvailableBooks = true
                self.getSelectedCategoryBooks()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedBook = self.bookList[indexPath.item]
        
        if let bookUrl = selectedBook.bookFormatUrl?.htmlUrl {
            UIApplication.shared.open(URL(string: bookUrl)!)
            return
        }
        
        if let bookUrl = selectedBook.bookFormatUrl?.htmlUrl {
            UIApplication.shared.open(URL(string: bookUrl)!)
            return
        }
        
        if let bookUrl = selectedBook.bookFormatUrl?.htmlUrl {
            UIApplication.shared.open(URL(string: bookUrl)!)
            return
        }
        
        self.showErrorAlertViewWithMessage(message: "Version of book is availale for required format.") {
            
        }
    }
}

extension BooksListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        if(searchBar.text != "")
        {
            self.getBooksBasedOnSearchString()
        }
        else
        {
            self.showWarningAlertViewWithMessage(message: "Please enter search text to search")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchBar.endEditing(true)
            self.showSearchedTextBooks = false
        }
    }
}

extension BooksListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  15
        let collectionViewWidth = collectionView.frame.size.width - padding
        let collectionViewHeight = collectionView.frame.size.height - padding
        
        var orientation: UIInterfaceOrientation? {
            get {
                guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
                    #if DEBUG
                    fatalError("Could not obtain UIInterfaceOrientation from a valid windowScene")
                    #else
                    return nil
                    #endif
                }
                return orientation
            }
        }
        
        if(orientation == .landscapeLeft || orientation == .landscapeRight)
        {
            return CGSize(width: collectionViewHeight/3, height:  (collectionViewHeight/3) + 60)
        }
        else{
            return CGSize(width: collectionViewWidth/3, height: (collectionViewWidth/3) + 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
