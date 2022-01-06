//
//  FlickrCollectionViewCell.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 6.01.2022.
//

import UIKit

final class FlickrImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var flickrImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupUI(image: UIImage?) {

        flickrImageView.image = image
    }
}
