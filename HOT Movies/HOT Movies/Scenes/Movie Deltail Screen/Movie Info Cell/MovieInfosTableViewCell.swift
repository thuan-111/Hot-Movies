//
//  MovieInfosTableViewCell.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 21/07/2021.
//

import UIKit
import Reusable
import Kingfisher
import Cosmos

final class MovieInfosTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var backdropImage: UIImageView!
    @IBOutlet private weak var movieTimeLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var rateIndexLabel: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    
    private var movieDetail = MovieDetailsModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        self.selectionStyle = .none
        posterImage.layer.cornerRadius = 5
        likeButton.tintColor = .red
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        playButton.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        playButton.tintColor = .white
    }
    
    @IBAction func didTapPlayButton(_ sender: Any) {
        
    }
    
    func configureCell(movie: MovieDetailsModel) {
        movieDetail = movie
        let posterUrl = URL(string: MovieURLs.shared.imageURL(imagePath: movie.posterPath))
        let backdropUrl = URL(string: MovieURLs.shared.imageURL(imagePath: movie.backdropPath))
        posterImage.kf.setImage(with: posterUrl)
        backdropImage.kf.setImage(with: backdropUrl)
        movieTitleLabel.text = movie.title
        cosmosView.rating = Double(movie.voteAverage / 2)
        rateIndexLabel.text = "\(movie.voteAverage)/10"
    }
}
