//
//  EndPointType.swift
//  NetworkingLibrary
//
//  Created by Varun Rathi on 29/05/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import UIKit

protocol EndPointType {
    
    var baseURL: URL {get}
    var path:String {get}
    var httpMethod:HTTPMethod {get}
    var task: HTTPTask {get}
    var headers:HTTPHeaders {get}
    
}
