//
//  ImageViewerViewController.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 2/1/22.
//

import UIKit

class ImagePlayerViewController: UIViewController, Storyboarded {

    // UI Elements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelCreatedAt: UILabel!

    // Variables
    weak var coordinator: AppCoordinator?
    let imageViewModel = ImageDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }

    func setData() {
        self.labelCreatedAt.text = imageViewModel.getCreatedAt()

        if let downloadURL = imageViewModel.media?.download_url, let url = URL(string: downloadURL) {
            MediaService.loadImage(url: url, indexPath: nil) {[weak self] result, _  in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.imageView.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}
