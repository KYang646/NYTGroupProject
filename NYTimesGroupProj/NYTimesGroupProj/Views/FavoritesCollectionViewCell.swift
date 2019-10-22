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
  
  lazy var summaryTextView: UITextView = {
    let textView = UITextView()
    textView.textAlignment = .center
    self.addSubview(textView)
    textView.isUserInteractionEnabled = false
    return textView
  }()
  
  lazy var weeksLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.textColor = .black
    label.font = UIFont.italicSystemFont(ofSize: 15)
    self.addSubview(label)
    return label
  }()
  
  lazy var bookTitleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 18)
    self.addSubview(label)
    return label
  }()
  
  private func setConstraints() {
    setBookImageConstraints()
    setSummaryTextViewConstraints()
    setWeeksLabelConstraints()
    setTitleLabelConstraints()
  }
  
  private func setBookImageConstraints(){
    bookImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bookImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      bookImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
      bookImage.widthAnchor.constraint(equalToConstant: 100),
      bookImage.heightAnchor.constraint(equalToConstant: 150)
    ])
  }
  
  private func setSummaryTextViewConstraints(){
    summaryTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      summaryTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      summaryTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
      summaryTextView.widthAnchor.constraint(equalToConstant: 340),
      summaryTextView.heightAnchor.constraint(equalToConstant: 70),
    ])
  }
  
  private func setWeeksLabelConstraints() {
    weeksLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      weeksLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      weeksLabel.topAnchor.constraint(equalTo: summaryTextView.topAnchor, constant: -50),
      weeksLabel.widthAnchor.constraint(equalTo: summaryTextView.widthAnchor),
      weeksLabel.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  private func setTitleLabelConstraints() {
    bookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bookTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      bookTitleLabel.topAnchor.constraint(equalTo: weeksLabel.topAnchor, constant: -30),
      bookTitleLabel.widthAnchor.constraint(equalTo: summaryTextView.widthAnchor),
      bookTitleLabel.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
    
    public func configureCell(from book: NYTimeBook) {
        self.layer.cornerRadius = 10
        backgroundColor =  #colorLiteral(red: 0.2914385796, green: 0.1974040866, blue: 0.4500601888, alpha: 1)
        bookTitleLabel.text = book.title
//        authorLabel.text = book.author
        
        summaryTextView.text = book.description
        //        weeksLabel.text = "\(book.weeks_on_list) weeks on best seller.."
        
        ImageHelper.shared.getImage(urlStr: book.book_image) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let imageFromOnline):
                DispatchQueue.main.async {
                    self.bookImage.image = imageFromOnline
                }
            }
        }
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.layer.cornerRadius = 10
      backgroundColor = .white
      setConstraints()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
}
