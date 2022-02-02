//
//  GalleryViewModel.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.
//

import Foundation
import UIKit

class GalleryViewModel {

    private var mediaService: MediaServiceProtocol

    init(mediaService: MediaServiceProtocol) {
        self.mediaService = mediaService

    }

    var medias: (([MediaModel]) -> Void)?
    var errorHandler: ((String) -> Void)?
    var loading: ((Bool) -> Void)?

    func getMedias() {
        self.loading?(true)
        if let medias = DataBaseManager.fetchAllMedias() { // we have data in database
            self.loading?(false)
            self.medias?(medias)
        } else {
            mediaService.getMedias { [weak self] mediasCallBack in
                guard let self = self else { return }
                self.loading?(false)
                switch mediasCallBack {
                case .success(let medias):
                    for media in medias {

                        DataBaseManager.saveMedia(media: media) {
                            print((media.filename ?? "no name") + " saved.")
                        } saveError: { error in
                            print(error)
                        }

                    }
                    self.medias?(medias)
                case .failure(let error):
                    self.errorHandler?(error.localizedDescription)
                }
            }
        }
    }

    func refreshMedias() {
        DataBaseManager.deleteAllMedia()
        MediaService.clearImageCache()
        self.loading?(true)
        mediaService.getMedias { [weak self] mediasCallBack in
            guard let self = self else { return }
            self.loading?(false)
            switch mediasCallBack {
            case .success(let medias):
                for media in medias {

                    DataBaseManager.saveMedia(media: media) {
                        print((media.filename ?? "no name") + " saved.")
                    } saveError: { error in
                        print(error)
                    }

                }
                self.medias?(medias)
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }

    func downloadThumbnail(item: MediaModel, size: CGSize, indexPath: IndexPath, completion: @escaping ImageResult) {
        if let thumbnail = item.thumbnail_url, var url = URL(string: thumbnail), let fileName = item.filename {
            let queryParams = "?w=" + String(Int(size.width)) + "&h=" + String(Int(size.height)) + "&m=md"
            url = url.appendingPathExtension(queryParams)
            MediaService.loadImage(url: url, indexPath: indexPath) { [completion] result, fileName  in
                switch result {
                case .success(let image):
                    completion(.success(image), fileName)
                case .failure(let error):
                    completion(.failure(error), fileName)
                }
            }
        }
    }

}
