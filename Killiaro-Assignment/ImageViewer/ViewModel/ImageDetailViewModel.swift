//
//  ImageDetailViewModel.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.
//

import Foundation

class ImageDetailViewModel {

    public var media: MediaModel!

    public func getCreatedAt() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        if let createdAt = media.created_at {
            return dateFormatter.string(from: createdAt)
        } else {
            return "Not Available"
        }

    }

}
