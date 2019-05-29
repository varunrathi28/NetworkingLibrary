//
//  Router.swift
//  NetworkingLibrary
//
//  Created by Varun Rathi on 29/05/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import Foundation

class Router <EndPoint:EndPointType> : NetworkRouter {
    
    private var task : URLSessionTask?
    func request(_ route: EndPoint, completion: @escaping NetworkCompletion) {
        
        let session = URLSession.shared
        
        do {
            
            let request  = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data,response,error)
            })
        }catch {
            completion(nil,nil,error)
        }
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    
    fileprivate  func buildRequest(from route:EndPoint) throws -> URLRequest{
        
        var request  = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(bodyParameters: let bodyParams, urlParameters: let urlParams):
                try self.configureParameters(bodyParams: bodyParams, urlParams: urlParams, request: &request)
                
            case .requestParametersAndHeaders(bodyParameters: let bodyParams, urlParameters: let urlParams, additionalParameters: let addParams):
               
               self.addAdditionalHeaders(addParams, request: &request)
               try self.configureParameters(bodyParams: bodyParams, urlParams: urlParams, request: &request)
            }
            return request
            
        } catch {
            throw error
        }
        
    }
    
    fileprivate func configureParameters(bodyParams:Parameters?, urlParams:Parameters?,request : inout URLRequest) throws {
    
        do {
            
            if let bodyparameters = bodyParams {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyparameters)
            }
            
            if let urlParameters = urlParams {
                try JSONParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        }
    catch {
            throw error
        }
    
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders:HTTPHeaders?, request: inout URLRequest) {
    
    guard let headers = additionalHeaders  else {
            return
        }
        
      for (key,value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    
}
