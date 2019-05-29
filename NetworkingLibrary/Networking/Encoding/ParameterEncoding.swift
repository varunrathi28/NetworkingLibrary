//
//  ParameterEncoding.swift
//  NetworkingLibrary
//
//  Created by Varun Rathi on 29/05/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import Foundation

public enum NetworkError : String, Error {
        case parametersNil = "Parameters are nil"
        case encodingFailed = "Parameter Encoding failed"
        case missingURL = "MissingURL"
}


public typealias Parameters = [String:Any]


public protocol ParameterEncoder {
 static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
