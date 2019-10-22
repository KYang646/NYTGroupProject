//
//  DetailViewController.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
   
    lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.red
        view.addSubview(imageView)
    
        return imageView
    }()
    
    lazy var bookTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.white
        textView.isEditable = false
        view.addSubview(textView)
        
        return textView
    }()
    
    lazy var bookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.imageView?.image = #imageLiteral(resourceName: "amazon-icon")
        button.setImage(#imageLiteral(resourceName: "amazon-icon"), for: .normal)
        button.addTarget(self, action: #selector(favoritesButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        
        return button
    }()
    
    var currentBook: NYTimeBook!
    
    @objc func favoritesButtonPressed(){
        let favoritedBook = currentBook
       
        do {
            try? FavoriteBookPersistenceHelper.manager.save(newBook: favoritedBook!)
        }
    }
    
    func setButtonConstraints() {
        NSLayoutConstraint.activate([
            bookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            bookButton.heightAnchor.constraint(equalToConstant: 70),
            bookButton.widthAnchor.constraint(equalToConstant: 70)
        
        ])
    }
    
    
    func setTextViewConstraints() {
        NSLayoutConstraint.activate([
            bookTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 170),
            bookTextView.heightAnchor.constraint(equalToConstant: 300),
            bookTextView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    
    func setBookImageConstraints() {
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            bookImage.heightAnchor.constraint(equalToConstant: 130),
            bookImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9799128175, blue: 0.8817918897, alpha: 1)
        setBookImageConstraints()
        setTextViewConstraints()
//        bookTextView.text = currentBook.bookDetails[0].bookDetailDescription

        setButtonConstraints()
    }
}
