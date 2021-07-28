//
//  SimilarMovieCollectionViewCell.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 23/07/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

final class SimilarMovieCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = 10
    }
    
    public func configureCell(movie: Movie) {
        let posterURL = URL(string: MovieURLs.shared.imageURL(imagePath: movie.posterPath))
        movieImageView.kf.setImage(with: posterURL)
        movieNameLabel.text = movie.title
    }
}
