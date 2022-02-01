//
//  Media.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.
//

import Foundation

struct MediaModel: Codable {
    let id: String?
    let content_type: String?
    let created_at: Date?
    let download_url: String?
    let filename: String?
    var md5sum: String?
    var media_type: String?
    var resx: Int64?
    var resy: Int64?
    var size: Int64?
    var taken_at: Date?
    var thumbnail_url: String?
    var user_id: String?


    func getSize() -> String {
        if let size = size {
            let fileSizeStr = ByteCountFormatter.string(fromByteCount: size, countStyle: ByteCountFormatter.CountStyle.memory)
            return fileSizeStr
        }else{
            return "N/A"
        }
    }
}

