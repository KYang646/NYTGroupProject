//
//  FavoritesCollectionViewCell.swift
//  NYTimesGroupProj
//
//  Created by Jocelyn Boyd on 10/21/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
  
  lazy var optionsButton: UIButton = {
    let button = UIButton()
    //        self.addSubview(button)
    return button
  }()
  
  lazy var bookImage: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .red
    self.addSubview(imageView)
    return imageView
  }()
  
  lazy var weeksLabel: UILabel = {
     let label = UILabel()
     label.textAlignment = .center
     label.text = "Weeks Label"
     label.backgroundColor = .brown
     
     label.adjustsFontSizeToFitWidth = true
     label.textColor = .black
     label.font = UIFont.italicSystemFont(ofSize: 15)
     self.addSubview(label)
     return label
   }()
  
  lazy var summaryTextView: UITextView = {
    let textView = UITextView()
    textView.textAlignment = .center
    textView.text = "Text View"
    textView.backgroundColor = .cyan
    
    self.addSubview(textView)
    textView.isUserInteractionEnabled = false
    return textView
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.cornerRadius = 10
    backgroundColor = .white
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setConstraints() {
    setBookImageConstraints()
    setWeeksLabelConstraints()
    setSummaryTextViewConstraints()
  }
  
  private func setBookImageConstraints(){
    bookImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
     bookImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      bookImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
      bookImage.widthAnchor.constraint(equalToConstant: 100),
      bookImage.heightAnchor.constraint(equalToConstant: 100),
    ])
  }
  
  private func setWeeksLabelConstraints() {
    weeksLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      weeksLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      weeksLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 10),
      weeksLabel.widthAnchor.constraint(equalTo: summaryTextView.widthAnchor),
      weeksLabel.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  private func setSummaryTextViewConstraints(){
    summaryTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      summaryTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      summaryTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      summaryTextView.topAnchor.constraint(equalTo: weeksLabel.bottomAnchor),
      summaryTextView.widthAnchor.constraint(equalTo: self.widthAnchor),
      summaryTextView.heightAnchor.constraint(equalToConstant: 90),
    ])
}
}
