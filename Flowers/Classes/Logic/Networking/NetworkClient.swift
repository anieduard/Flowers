//
//  NetworkClient.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkClient {
    
    // MARK: - Public properties
    
    private(set) lazy var baseURL: URLComponents = {
        var components = URLComponents()
        components.scheme = APIConstants.URL.scheme
        components.host = APIConstants.URL.host
        return components
    }()
    
    // MARK: - Private properties
    
    private let session: SessionManager
    
    private lazy var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return jsonDecoder
    }()
    
    // MARK: - Init
    
    init(session: SessionManager = .default) {
        self.session = session
    }
    
    // MARK: - Logic
    
    private func performRequest(_ request: URLRequest, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        session.request(request)
            .validate()
            .response { response in
                if let error = response.error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = response.data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                completion(.success(data))
            }
    }
    
    func performRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        performRequest(request) { [weak self] result in
            guard let self = self else { return }
            
            do {
                let object = try self.jsonDecoder.decode(T.self, from: result.get())
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
