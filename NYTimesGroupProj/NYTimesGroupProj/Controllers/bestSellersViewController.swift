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
        collectionView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "bookCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        return collectionView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NYT Bestsellers"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        return label
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
            print(selectedCategory)
        }
    }
    
    private func loadCategoriesData() {
        NYTimesCategoriesAPIClient.shared.getCategories { (result) in
            switch result {
            case .success(let categoryData):
                self.categories = categoryData
                
            case .failure(let error):
                print(error)
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
    
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
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
        setTitleLabelConstraints()
        setPickerConstraints()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9799128175, blue: 0.8817918897, alpha: 1)
        setConstraints()
        loadCategoriesData()
        
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
        
        let index = specificBook.isbns.indexExists(1) == true ? 1 : 0
        
        GoogleBooksAPIClient.shared.getGoogleBooks(isbn10: specificBook.isbns[index].isbn10) { (result) in
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
        return bookCell
    }
}

extension bestSellersViewController: UICollectionViewDelegate {
    
}

extension bestSellersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 350)
    }
}

//MARK: -- PickerView DataSource/Delegate
extension bestSellersViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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

extension Array {
  func indexExists(_ index: Int) -> Bool {
    return self.indices.contains(index)
  }
}
