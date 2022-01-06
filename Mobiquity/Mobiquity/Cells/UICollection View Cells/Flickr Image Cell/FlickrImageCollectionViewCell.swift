//
//  FlickrCollectionViewCell.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 6.01.2022.
//

import UIKit

final class FlickrImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var flickrImageView: UIImageView!

    var presentation: FlickrImageCollectionViewCellPresentation? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateUI() {
        if let url = URL(string: presentation?.url) {
        } else {
            flickrImageView.image = nil
        }
    }
}
