//
//  SimilarMoviesTableViewCell.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 21/07/2021.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import NSObject_Rx

final class SimilarMoviesTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var similarLabel: UILabel!
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    
    var similarMovieTapped: ((Movie) -> Void)?
    
    private var movies = [Movie]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configureCollectionView()
    }
    
    private func configureView() {
        self.selectionStyle = .none
        similarLabel.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        similarLabel.layer.cornerRadius = 5
    }
    
    private func configureCollectionView() {
        moviesCollectionView.do {
            $0.register(cellType: SimilarMovieCollectionViewCell.self)
            $0.dataSource = self
            $0.delegate = self
            configureLayoutCollectionView()
        }
    }
    
    private func configureLayoutCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 0
            $0.itemSize = CGSize(width: 150, height: 250)
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        moviesCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    public func configureCell(movies: [Movie]) {
        self.movies = movies
    }
}

extension SimilarMoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: SimilarMovieCollectionViewCell.self)
        cell.configureCell(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        similarMovieTapped?(movies[indexPath.row])
    }
}
