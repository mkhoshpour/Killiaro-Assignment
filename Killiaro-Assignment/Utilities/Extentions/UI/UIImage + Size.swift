//
//  UIImage.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 2/1/22.
//

import UIKit

extension UIImage {
    func getSize() -> String {
        if let data = self.jpegData(compressionQuality: 1.0) {
            let fileSizeStr = ByteCountFormatter.string(fromByteCount: Int64(data.count), countStyle: ByteCountFormatter.CountStyle.memory)
            return fileSizeStr
        } else {
            return "N/A"
        }
    }
}
