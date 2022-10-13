//
//  FlickrCollectionViewCell.swift
//  Flickr
//
//  Created by Emrah Akgül on 6.01.2022.
//

import UIKit
import Kingfisher

final class FlickrImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var flickrImageView: UIImageView!
    var indexPath: IndexPath!

    private var presentation: FlickrImageCollectionViewCellPresentation? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupUI(
        presentation: FlickrImageCollectionViewCellPresentation?,
        indexPath: IndexPath
    ) {
        self.presentation = presentation
        self.indexPath = indexPath
    }

    private func updateUI() {
        DispatchQueue.global(qos: .background).sync { [weak self] in
            guard let self = self else { return }
            if let url = URL(string: self.presentation?.url ?? "") {
                DispatchQueue.main.async {
                    self.flickrImageView.kf.setImage(with: url)
                }
            } else {
                DispatchQueue.main.async {
                    self.flickrImageView.image = nil
                }
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        flickrImageView.image = nil
        flickrImageView.kf.cancelDownloadTask()
    }
}
