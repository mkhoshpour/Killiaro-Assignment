//
//  GalleryViewController.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.
//

import UIKit

class GalleryViewController: UIViewController, Storyboarded {

    // UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    var cellHeight = CGFloat(140)


    var medias = [MediaModel]()

    weak var coordinator: AppCoordinator?

    let galleryViewModel = GalleryViewModel(mediaService: MediaService.shared)


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        // Do any additional setup after loading the view.
    }

    func setupView(){
        self.title = "Gallery"

        self.collectionView.registerCell(type: MediaCell.self)
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
    }
    

    // MARK: - Bindings
    private func setupBindings() {

        // Subscribe to Loading
        galleryViewModel.loading = { [weak self] isLoading in
            guard let self = self else { return }
//            isLoading ? self.loading.startAnimating() : self.loading.stopAnimating()
        }

        // Subscribe to apartments
        galleryViewModel.medias = { [weak self] medias in
            guard let self = self else { return }
            // Add new apartments to tableView dataSource.
            self.medias = medias
            self.collectionView.reloadData()
//            self.apartmentsTableViewDataSource.refreshWithNewItems(apartments)
        }

        // Subscribe to errors
        galleryViewModel.errorHandler = { [weak self] error in
            guard let self = self else { return }
//            self.showAlertWith(error, title: "Error", completion: nil)
        }
    }

}




// MARK: - UICollectionView DataSource
extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medias.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueCell(withType: MediaCell.self, for: indexPath) as? MediaCell {
            let media = medias[indexPath.row]
            let width = collectionView.frame.width / 3
            let size = CGSize(width: width, height: cellHeight)
            cell.configureCellWith(media, size: size)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

}

// MARK: - UICollectionView DelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        return CGSize(width: width, height: cellHeight)
    }

}
