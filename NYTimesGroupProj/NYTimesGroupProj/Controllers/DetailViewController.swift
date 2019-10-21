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
        view.addSubview(textView)
        
        return textView
    }()
    
    var currentBook: SearchResult!
    
    
    func setTextViewConstraints() {
        NSLayoutConstraint.activate([
            bookTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            bookTextView.heightAnchor.constraint(equalToConstant: 300),
            bookTextView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    let exampleBook = BookDetail(title: "Cat In The Hat", bookDetailDescription: "The Cat in the Hat is a book where an eccentric stranger (who's a cat!) comes into the house of two young children, Sally and Sam, who are having a very dull day. Their mother is out, and when the Cat comes in, he reassures the kids that their mother won't mind him or his tricks!", author: "Dr.Seuss", primaryIsbn13: "‎978-0394800011", primaryIsbn10: "039480001X")
    
    func setBookImageConstraints() {
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            bookImage.heightAnchor.constraint(equalToConstant: 150),
            bookImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9799128175, blue: 0.8817918897, alpha: 1)
        setBookImageConstraints()
        setTextViewConstraints()
//        bookTextView.text = currentBook.bookDetails[0].bookDetailDescription
    }
}
