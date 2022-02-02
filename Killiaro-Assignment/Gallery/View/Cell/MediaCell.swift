//
//  MediaCell.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 2/1/22.
//

import UIKit

class MediaCell: UICollectionViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageThumbnail: UIImageView!

    var index: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCellWith(_ item: MediaModel, size: CGSize, index: IndexPath) {
        labelName.text = item.getSize()
        imageThumbnail.image = UIImage(named: "placeholder")
        self.index = index
    }

    func setThumbnail(image: UIImage) {
        self.imageThumbnail.image = image
    }
}
