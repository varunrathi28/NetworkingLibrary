//
//  Router.swift
//  NetworkingLibrary
//
//  Created by Varun Rathi on 29/05/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import Foundation

public typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

 protocol NetworkRouter: class  {
    associatedtype EndPoint:EndPointType
    func request(_ route:EndPoint, completion:@escaping NetworkCompletion)
    func cancel()
}
