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
        
    }
}

//MARK: -- Extensions
extension bestSellersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bookCell = booksCollectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        
        
        bookCell.summaryTextView.text = "hi"
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
        let genreNames = ["Hardcover Fiction", "Hardcover Non-Fiction", "Mass Market Paperback", "Paperback Non Fiction", "E-Book Fiction"]
        return genreNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let genreNames = ["Hardcover Fiction", "Hardcover Non-Fiction", "Mass Market Paperback", "Paperback Non Fiction", "E-Book Fiction"]
        return genreNames[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("You selected row \(row)")
    }
}
