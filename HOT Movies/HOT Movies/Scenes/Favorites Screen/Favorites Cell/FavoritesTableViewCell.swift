//
//  FavoritesTableViewCell.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 29/07/2021.
//

import UIKit
import Reusable

final class FavoritesTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var rateAverageLabel: UILabel!
    @IBOutlet private weak var releaseDataLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!
    
    var removeButtonTapped: ((Movie) -> Void)?
    private var movie = Movie()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        selectionStyle = .none
        posterImageView.layer.cornerRadius = 15
        rateAverageLabel.layer.cornerRadius = 5
        rateAverageLabel.textColor = .white
        rateAverageLabel.layer.backgroundColor = #colorLiteral(red: 0.176916459, green: 0.3618177563, blue: 0.5959457317, alpha: 1)
        removeButton.backgroundColor = #colorLiteral(red: 0.7631706763, green: 0, blue: 0.01897420928, alpha: 1)
        removeButton.layer.cornerRadius = 7
    }
    
    @IBAction func didTapRemoveButton(_ sender: Any) {
        removeButtonTapped?(movie)
    }
    
    public func configureCell(movie: Movie) {
        self.movie = movie
        let imageUrlString = MovieURLs.shared.imageURL(imagePath: movie.posterPath)
        let imageUrl = URL(string: imageUrlString)
        movieName.text = movie.title
        releaseDataLabel.text = movie.releaseDate
        posterImageView.kf.setImage(with: imageUrl)
        let voteAverageFormatted = Float(Int(movie.voteAverage * 10)) / 10.0
        rateAverageLabel.text = String(voteAverageFormatted)
    }
}
