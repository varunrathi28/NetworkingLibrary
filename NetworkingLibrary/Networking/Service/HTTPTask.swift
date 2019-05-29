//
//  HTTPTask.swift
//  NetworkingLibrary
//
//  Created by Varun Rathi on 29/05/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters : Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters : Parameters?, urlParameters: Parameters?,additionalParameters:HTTPHeaders)
}
