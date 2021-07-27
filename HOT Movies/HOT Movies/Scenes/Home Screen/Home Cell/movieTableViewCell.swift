//
//  movieTableViewCell.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 15/07/2021.
//

import UIKit
import Kingfisher
import Reusable

final class movieTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var rateAverageLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var gradientView: UIView!
    
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
        configureTrailerLabel()
    }
    
    private func configureTrailerLabel() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.do {
            $0.frame = gradientView.bounds
            $0.colors = [
                UIColor.systemGreen.cgColor,
                UIColor.systemYellow.cgColor,
                UIColor.systemOrange.cgColor,
                UIColor.systemRed.cgColor
            ]
            $0.startPoint = CGPoint(x: 0.0, y: 0.5)
            $0.endPoint = CGPoint(x: 1.0, y: 0.5)
            $0.cornerRadius = 10
        }
        
        let trailerlabel = UILabel()
        trailerlabel.do {
            $0.text = "Trailer"
            $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            $0.font = UIFont.boldSystemFont(ofSize: 19)
            $0.textAlignment = .center
            $0.frame = gradientView.bounds
        }
        
        gradientView.do {
            $0.layer.addSublayer(gradientLayer)
            $0.addSubview(trailerlabel)
            $0.layer.cornerRadius = 10
        }
    }
    
    public func configureCell(movie: Movie) {
        let imageUrlString = MovieURLs.shared.imageURL(imagePath: movie.posterPath)
        let imageUrl = URL(string: imageUrlString)
        posterImageView.kf.setImage(with: imageUrl)
        movieNameLabel.text = movie.title
        rateAverageLabel.text = String(movie.voteAverage)
        releaseDateLabel.text = movie.releaseDate
    }
}
