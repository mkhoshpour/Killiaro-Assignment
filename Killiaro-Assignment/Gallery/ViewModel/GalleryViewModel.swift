//
//  GalleryViewModel.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.
//

import Foundation


class GalleryViewModel {

    private var mediaService: MediaServiceProtocol

    init(mediaService: MediaServiceProtocol) {
        self.mediaService = mediaService
        getMedias()
    }


    var medias: (([MediaModel]) -> Void)?
    var errorHandler: ((String) -> Void)?
    var loading: ((Bool) -> Void)?


    func getMedias() {
        self.loading?(true)
        mediaService.getMedias { [weak self] mediasCallBack in
            guard let self = self else { return }
            self.loading?(false)
            switch mediasCallBack {
            case .success(let medias):
                self.medias?(medias)
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }


}
