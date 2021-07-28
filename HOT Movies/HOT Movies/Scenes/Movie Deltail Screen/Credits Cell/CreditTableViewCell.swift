//
//  CreditTableViewCell.swift
//  HOT Movies
//
//  Created by Thuận Nguyễn Văn on 23/07/2021.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import NSObject_Rx

final class CreditTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var creditLabel: UILabel!
    @IBOutlet private weak var creditCollectionView: UICollectionView!
    
    private var credits = [CastAndCrewModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configureCollectionView()
    }
    
    private func configureView() {
        self.selectionStyle = .none
        creditLabel.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        creditLabel.layer.cornerRadius = 5
    }
    
    private func configureCollectionView() {
        creditCollectionView.do {
            $0.register(cellType: CastAndCrewCollectionViewCell.self)
            $0.dataSource = self
            $0.delegate = self
        }
        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 0
            $0.itemSize = CGSize(width: 100, height: 180)
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        creditCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    public func configureCell(credits: CreditModel) {
        self.credits = credits.cast
    }
}

extension CreditTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return credits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: CastAndCrewCollectionViewCell.self)
        cell.configureCell(castAndCrew: credits[indexPath.row])
        return cell
    }
}
