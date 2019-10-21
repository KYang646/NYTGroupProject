//
//  FavoritesViewController.swift
//  NYTimesGroupProj
//
//  Created by Kimball Yang on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    //MARK: -- Properties
    lazy var favsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .lightGray
        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "favoritesCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    var books = [SearchResult]() {
        didSet {
            favsCollectionView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        loadFavsData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9799128175, blue: 0.8817918897, alpha: 1)
        setCollectionViewConstraints()
    }
    
    
    private func loadFavsData() {
        try! books = FavoriteBookPersistenceHelper.manager.getBooks()
    }
    
    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            favsCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            favsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            favsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}

//MARK: -- Extensions
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favsCell = favsCollectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as! FavoritesCollectionViewCell
        
        
        return favsCell
    }
}



extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 350)
    }
}



