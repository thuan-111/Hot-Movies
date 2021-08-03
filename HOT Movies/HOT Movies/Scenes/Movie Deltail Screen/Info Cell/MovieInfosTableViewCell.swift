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
import RxCocoa
import RxSwift

final class MovieInfosTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var backdropImage: UIImageView!
    @IBOutlet private weak var movieTimeLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var rateIndexLabel: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    
    var likeButtonTapped: ((Bool) -> Void)?
    var playButtonTapped: ((String?) -> Void)?
    
    private var isLiked = false
    private var key: String?
    
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
    
    private func configureLikeButton(isLiked: Bool) {
        likeButton.tintColor = isLiked ? Asset.likedColor.color : Asset.unLikedColor.color
    }
    
    @IBAction func didTapLikeButton(_ sender: Any) {
        likeButtonTapped?(isLiked)
    }
    
    @IBAction func didTapPlayButton(_ sender: Any) {
        playButtonTapped?(key)
    }
    
    func configureCell(movie: MovieDetailsModel, likedStatus: Bool) {
        isLiked = likedStatus
        key = movie.videos.results.first?.key
        let posterUrl = URL(string: MovieURLs.shared.imageURL(imagePath: movie.posterPath))
        let backdropUrl = URL(string: MovieURLs.shared.imageURL(imagePath: movie.backdropPath))
        posterImage.kf.setImage(with: posterUrl)
        backdropImage.kf.setImage(with: backdropUrl)
        movieTitleLabel.text = movie.title
        movieTimeLabel.text = ("\(movie.runtime)min")
        cosmosView.rating = Double(movie.voteAverage / 2)
        let voteAverageFormatted = Float(Int(movie.voteAverage * 10)) / 10.0
        rateIndexLabel.text = "\(voteAverageFormatted)/10"
        configureLikeButton(isLiked: isLiked)
    }
}
