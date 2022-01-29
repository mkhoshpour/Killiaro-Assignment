//
//  ResponseValidatorProtocol.swift
//  Airmee
//
//  Created by Majid Khoshpour on 1/29/22.
//

import Foundation

protocol ResponseValidatorProtocol {
    func validation<T: Codable>(response: HTTPURLResponse?, data: Data?) -> Result<T, RequestError>
}
