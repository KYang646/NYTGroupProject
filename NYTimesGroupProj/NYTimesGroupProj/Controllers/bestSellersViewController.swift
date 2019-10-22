//
//  ViewController.swift
//  NYTimesGroupProj
//
//  Created by Kimball Yang on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class bestSellersViewController: UIViewController {
    //MARK: -- Properties
    
    
    lazy var booksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.438677609, green: 0.432184577, blue: 0.5881646276, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "bookCell")
        view.addSubview(collectionView)
        return collectionView
    }()
    
    lazy var genrePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        return picker
    }()
    
    var books = [SearchResult]() {
        didSet {
            booksCollectionView.reloadData()
        }
    }
    
    var categories = [ListNameResult]() {
        didSet {
            genrePicker.reloadAllComponents()
        }
    }
    
    var selectedCategory = String() {
        didSet {
            loadBooksInSelectedCategory()
//            print(selectedCategory)

        }
    }
    
    private func loadCategoriesData() {
        NYTimesCategoriesAPIClient.shared.getCategories { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let categoryData):
                    self.categories = categoryData
                    //self.loadUserDefaults()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func loadBooksInSelectedCategory() {
        NYTimesBooksAPIClient.shared.getCategories(categoryName: selectedCategory) { (result) in
            switch result {
            case .success(let booksFromOnline):
                self.books = booksFromOnline
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    //MARK: -- Constraints
    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            booksCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            booksCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            booksCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            booksCollectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func setPickerConstraints() {
        NSLayoutConstraint.activate([
            genrePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genrePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
            genrePicker.heightAnchor.constraint(equalToConstant: 450),
            genrePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    private func setConstraints(){
        setCollectionViewConstraints()
        setPickerConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9763752818, green: 0.9765191674, blue: 0.9763557315, alpha: 1)
        setConstraints()
        loadCategoriesData()
        //loadUserDefaults()
    }
    
    private func loadUserDefaults(){
        if let rowInteger = UserDefaults.standard.object(forKey: "rowNumber") as? Int, let category = UserDefaults.standard.object(forKey: "categoryName") as? String{
            selectedCategory = category
            genrePicker.selectRow(rowInteger, inComponent: 0, animated: true)
            loadBooksInSelectedCategory()
        } else {
            selectedCategory = categories[0].listNameEncoded
        }
        //\loadBooksInSelectedCategory()
    }
    
}


//MARK: -- Extensions
extension bestSellersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bookCell = booksCollectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        let specificBook = books[indexPath.row]
        bookCell.configureCell(from: specificBook)

        
        let index = specificBook.isbns.indices.contains(1) == true ? 1 : 0
        
        GoogleBooksAPIClient.shared.getGoogleBooks(isbn10: specificBook.bookDetails[0].primaryIsbn13) { (result) in
            switch result {
            case .success(let googleBookData):
                print(googleBookData)
                ImageHelper.shared.getImage(urlStr: googleBookData.items[0].volumeInfo.imageLinks.thumbnail) { (result) in
                    switch result {
                    case .success(let imageFromAPI):
                        DispatchQueue.main.async {
                            bookCell.bookImage.image = imageFromAPI
                        }
                        
                    case .failure(let error):
                        print(error)
                        bookCell.bookImage.image = #imageLiteral(resourceName: "noImage")

        if let bookExist = specificBook.bookDetails.first {
        //        let index = specificBook.bookDetails[0].primaryIsbn10
        //        let index = specificBook.isbns.indexExists(1) == true ? 1 : 0
            
            GoogleBooksAPIClient.shared.getGoogleBooks(isbn10: bookExist.primaryIsbn13 ) { (result) in
                switch result {
                case .success(let googleBookData):
                    print(googleBookData)
                    ImageHelper.shared.getImage(urlStr: googleBookData.items[0].volumeInfo.imageLinks.thumbnail) { (result) in
                        switch result {
                        case .success(let imageFromAPI):
                            DispatchQueue.main.async {
                                bookCell.bookImage.image = imageFromAPI
                            }
                            
                            
                        case .failure(let error):
                            print(error)
                            
                        }

                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        return bookCell
    }
}

extension bestSellersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        let currentBook = books[indexPath.row]
        detailVC.currentBook = currentBook
    
        
        self.navigationController?
            .pushViewController(detailVC, animated: true)
    }
}

extension bestSellersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 350)
    }
}

//MARK: -- PickerView DataSource/Delegate
extension bestSellersViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].displayName
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row].listNameEncoded
    }
    
    
}


//extension Array {
//  func indexExists(_ index: Int) -> Bool {
//    return self.indices.contains(index)
//  }
//}

extension Array {
    func indexExists(_ index: Int) -> Bool {
        return self.indices.contains(index)
    }
}

