//
//  FlickrCollectionViewCell.swift
//  Mobiquity
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

    public override var intrinsicContentSize: CGSize {
        return flickrImageView.image?.size ?? .zero
    }

    private func updateUI() {
        if let url = URL(string: presentation?.url ?? "") {
            flickrImageView.kf.setImage(with: url)
        } else {
            flickrImageView.image = nil
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        flickrImageView.image = nil
        flickrImageView.kf.cancelDownloadTask()
    }
}
