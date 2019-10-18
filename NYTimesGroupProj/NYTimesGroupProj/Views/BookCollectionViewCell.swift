//
//  BookCollectionViewCell.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        return imageView
        
    }()
    
    lazy var summaryTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .green
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textView)
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    lazy var weeksLabel: UILabel = {
        let label = UILabel()
        label.text = "I JUST LOVE TAKING SHITS IN COLLECTION VIEWS"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    private func setConstraintsForBookImage(){
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bookImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            bookImage.widthAnchor.constraint(equalToConstant: 100),
            bookImage.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setSummaryTextViewConstraints(){
        NSLayoutConstraint.activate([
            summaryTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            summaryTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            summaryTextView.widthAnchor.constraint(equalToConstant: 300),
            summaryTextView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func setLabelConstraints() {
        NSLayoutConstraint.activate([
            weeksLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weeksLabel.topAnchor.constraint(equalTo: summaryTextView.topAnchor, constant: -50),
            weeksLabel.widthAnchor.constraint(equalTo: summaryTextView.widthAnchor),
            weeksLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setConstraints(){
        setConstraintsForBookImage()
        setSummaryTextViewConstraints()
        setLabelConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        self.layer.cornerRadius = 10
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
