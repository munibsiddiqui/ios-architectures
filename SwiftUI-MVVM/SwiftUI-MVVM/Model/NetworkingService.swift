//
//  NetworkingService.swift
//  SwiftUI-MV
//
//  Created by GoEun Jeong on 2021/05/12.
//

import Moya

protocol NetworkingService {
    func request(_ api: BeerAPI, completion: @escaping (Result<[Beer], Error>) -> Void)
}

final class NetworkingAPI: NetworkingService {
    let provider: MoyaProvider<BeerAPI>
    
    init(provider: MoyaProvider<BeerAPI> = MoyaProvider<BeerAPI>()) {
        self.provider = provider
    }
    
    func request(_ api: BeerAPI, completion: @escaping (Result<[Beer], Error>) -> Void) {
        provider.request(api) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let decoded = try JSONDecoder().decode([Beer].self, from: responseData)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
