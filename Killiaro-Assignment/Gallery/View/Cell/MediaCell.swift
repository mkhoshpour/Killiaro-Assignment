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



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configureCellWith(_ item: MediaModel, size: CGSize) {
        labelName.text = item.getSize()
        imageThumbnail.image = nil
        if let thumbnail = item.thumbnail_url, var url = URL(string: thumbnail) {
            let queryParams = "?w=" + String(Int(size.width)) + "&h=" + String(Int(size.height)) + "&m=md"
            url = url.appendingPathExtension(queryParams)
            MediaService.loadImage(url: url) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.imageThumbnail.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

    }
}
