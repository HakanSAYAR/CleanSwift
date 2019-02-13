//
//  Router.swift
//  iOSChallenge
//
//  Created by Hakan SAYAR on 9.02.2019.
//  Copyright © 2019 Hakan SAYAR. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()
public typealias NetworkRouterDecodableCompletion<T: Decodable> = (_ model: T?,_ error: String?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.main.async {
                    completion(data, response, error)
                }
            })
        }catch {
            DispatchQueue.main.async {
                completion(nil, nil, error)
            }
        }
        self.task?.resume()
    }
    
    
    
    func requestDecodable<T: Decodable>(_ type: T.Type, _ route: EndPoint, completion: @escaping NetworkRouterDecodableCompletion<T>) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                if error != nil {
                    DispatchQueue.main.async {
                        completion(nil, "Please check your network connection.")
                    }
                }
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            DispatchQueue.main.async {
                                completion(nil, NetworkResponse.noData.rawValue)
                            }
                            return
                        }
                        do {
                            print(responseData)
                            
                            let apiResponse = try JSONDecoder().decode(type, from: responseData)
                            DispatchQueue.main.async {
                                completion(apiResponse, nil)
                            }
                            
                        }catch {
                            print(error)
                            DispatchQueue.main.async {
                                completion(nil, NetworkResponse.unableToDecode.rawValue)
                            }
                        }
                    case .failure(let networkFailureError):
                        DispatchQueue.main.async {
                            completion(nil, networkFailureError)
                        }
                    }
                }
            })
        }catch {
            DispatchQueue.main.async {
                completion(nil, error.localizedDescription)
            }
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: Service.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let parameters, let encoding):
                
                try self.configureParameters(parameters: parameters,
                                             encoding: encoding,
                                             request: &request)
                
            case .requestParametersAndHeaders(let parameters,
                                              let encoding,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(parameters: parameters, encoding: encoding, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(parameters: Parameters?,
                                         encoding: ParameterEncoding,
                                         request: inout URLRequest) throws {
        do {
            try encoding.encode(urlRequest: &request, parameters: parameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

