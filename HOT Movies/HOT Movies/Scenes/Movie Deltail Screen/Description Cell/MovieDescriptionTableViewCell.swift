//
//  MovieDescriptionTableViewCell.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 21/07/2021.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

final class MovieDescriptionTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var descriptionHeightContraint: NSLayoutConstraint!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var showMoreButton: UIButton!
    
    var showMoreButtonTapped: (() -> Void)?
    
    private var textIsFullSize = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        self.selectionStyle = .none
        descriptionTextView.textColor = #colorLiteral(red: 0.2809994221, green: 0.3207833767, blue: 0.3707251847, alpha: 1)
        descriptionTextView.isEditable = false
        descriptionTextView.showsVerticalScrollIndicator = false
    }
    
    func configureCell(description: String) {
        descriptionTextView.text = description
    }
    
    @IBAction func didTapShowMoreButton(_ sender: Any) {
        textIsFullSize = !textIsFullSize
        reloadTextViewStatus()
        showMoreButtonTapped?()
    }
    
    private func reloadTextViewStatus() {
        if textIsFullSize {
            descriptionHeightContraint.constant = descriptionTextView.contentSize.height + 10
            showMoreButton.setTitle("show less", for: .normal)
        } else {
            descriptionHeightContraint.constant = 120
            showMoreButton.setTitle("show more", for: .normal)
        }
    }
}
