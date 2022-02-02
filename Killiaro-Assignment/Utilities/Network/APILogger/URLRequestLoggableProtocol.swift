//
//  URLRequestLoggableProtocol.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 1/29/22.

import Foundation

protocol URLRequestLoggableProtocol {
    func logResponse(_ response: HTTPURLResponse?, data: Data?, error: Error?, HTTPMethod: String?)
}
