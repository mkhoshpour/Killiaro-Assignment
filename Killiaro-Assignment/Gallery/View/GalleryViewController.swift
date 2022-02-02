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
    @IBOutlet var loading: UIActivityIndicatorView! {
        didSet {
            loading.hidesWhenStopped = true
        }
    }

    var medias = [MediaModel]()

    weak var coordinator: AppCoordinator?

    let galleryViewModel = GalleryViewModel(mediaService: MediaService.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        galleryViewModel.getMedias()

    }

    func setupView() {
        self.title = "Gallery"

        self.collectionView.registerCell(type: MediaCell.self)

        // add reload button
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        self.navigationItem.rightBarButtonItem = reloadButton

    }

    // MARK: - Bindings
    private func setupBindings() {

        // Subscribe to Loading
        galleryViewModel.loading = { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.loading.startAnimating() : self.loading.stopAnimating()

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
        galleryViewModel.errorHandler = { [weak self] _ in
            guard let self = self else { return }
//            self.showAlertWith(error, title: "Error", completion: nil)
        }
    }

    @objc func refreshData() {
        galleryViewModel.refreshMedias()
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
            cell.configureCellWith(media, size: size, index: indexPath)
            galleryViewModel.downloadThumbnail(item: media, size: size, indexPath: indexPath) { result, index  in
                switch result {
                case .success( let image):
                    if let index = index, let cellIndex = cell.index {
                        if cellIndex.row == index.row {
                            cell.setThumbnail(image: image)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
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

// MARK: - UICollectionView Delegate
extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.coordinator?.navigateToDetailView(medias[indexPath.row])
    }
}
