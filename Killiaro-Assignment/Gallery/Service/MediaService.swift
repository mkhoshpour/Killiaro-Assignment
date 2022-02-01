//
//  MediaService.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.
//

import UIKit
import Kingfisher

/*

 This is Media Service, responsible for making api calls of getting all medias.

 */

typealias MediasCompletionHandler = (Result<[MediaModel], RequestError>) -> Void
typealias ImageResult = (Result<UIImage, Error>) -> Void


protocol MediaServiceProtocol {
    func getMedias(completionHandler: @escaping MediasCompletionHandler)
}

/*

 ApartmentEndpoint is URLPath of Apartment Api calls

*/

private enum MediaEndpoint {

    case medias

    var path: String {
        switch self {
        case .medias:
            return "/media"
        }
    }
}

class MediaService: MediaServiceProtocol {

    private let requestManager: RequestManagerProtocol

    public static let shared: MediaServiceProtocol = MediaService(requestManager: RequestManager.shared)

    // We can also inject requestManager for testing purposes.
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }

    func getMedias(completionHandler: @escaping MediasCompletionHandler) {
        self.requestManager.performRequestWith(url: MediaEndpoint.medias.path, httpMethod: .get) { (result: Result<[MediaModel], RequestError>) in
            completionHandler(result)
        }
    }



    static func loadImage(url: URL, result: @escaping ImageResult) {
        // KingFisher needs imageView to set image to, but we only need image

        KF.url(url)
            .placeholder(UIImage(named: "foodPlaceholder"))
            .loadDiskFileSynchronously()
            .cacheMemoryOnly(false)
            .waitForCache(true)
            .fade(duration: 0.25)
            .onSuccess { data in
                if let image = data.image.imageAsset?.image(with: .current) {
                    result(.success(image))
                }
            }
            .onFailure { error in
                print(error)
            }
            .set(to: UIImageView())
    }
}



