//
//  CastAndCrewCollectionViewCell.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 23/07/2021.
//

import UIKit
import Reusable
import Kingfisher

final class CastAndCrewCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        avatarImage.layer.cornerRadius = 8
    }
    
    public func configureCell(castAndCrew: CastAndCrewModel) {
        let imageURL = URL(string: MovieURLs.shared.imageURL(imagePath: castAndCrew.profilePath))
        avatarImage.kf.setImage(with: imageURL)
        nameLabel.text = castAndCrew.name
    }

}
