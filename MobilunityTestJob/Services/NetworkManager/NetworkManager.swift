//
//  NetworkManager.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol NetworkManagerProtocol {
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response>
}

final class NetworkManager: NetworkManagerProtocol {
    private let manager: Alamofire.Session
    private let queue = DispatchQueue(label: "NetworkingClientQueue")

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        self.manager = Alamofire.Session(configuration: configuration)
    }

    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response> {
        return Single<Response>.create { observer in
            let request = self.manager.request(
                endpoint.path,
                method: self.httpMethod(from: endpoint.method),
                parameters: endpoint.parameters
            )
            request
                .validate()
                .responseData(queue: self.queue) { response in
                    let result = response.result.flatMap { data -> Result<Response, AFError> in
                        do {
                            let response = try endpoint.decode(data)
                            return .success(response)
                        } catch {
                            return .failure(.responseSerializationFailed(reason: .decodingFailed(error: error)))
                        }
                    }
                    switch result {
                    case let .success(val): observer(.success(val))
                    case let .failure(err): observer(.error(err))
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func httpMethod(from method: HttpMethod) -> Alamofire.HTTPMethod {
        switch method {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        }
    }
}
