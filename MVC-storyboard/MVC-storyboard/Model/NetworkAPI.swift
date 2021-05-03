//
//  NetworkAPI.swift
//  MVC-storyboard
//
//  Created by GoEun Jeong on 2021/04/28.
//

import Foundation

protocol NetworkingService {
    func getBeerList(page: Int, completion: @escaping ([Beer]) -> ())
    func searchBeer(id: Int, completion: @escaping ([Beer]) -> ())
    func getRandomBeer(completion: @escaping ([Beer]) -> ())
}

final class NetworkingAPI: NetworkingService {
    let session = URLSession.shared
    
    func getBeerList(page: Int, completion: @escaping ([Beer]) -> ()) {
        let request = URLRequest(url: URL(string: "https://api.punkapi.com/v2/beers?per_page=25&page=\(page)")!)
        let task = session.dataTask(with: request) { (data, _, _) in
            guard let data = data,
                  let response = try? JSONDecoder().decode([Beer].self, from: data) else {
                completion([])
                return
            }
            completion(response)
        }
        task.resume()
    }
    
    func searchBeer(id: Int, completion: @escaping ([Beer]) -> ()) {
        let request = URLRequest(url: URL(string: "https://api.punkapi.com/v2/beers?ids=\(id)")!)
        let task = session.dataTask(with: request) { (data, _, _) in
            guard let data = data,
                  let response = try? JSONDecoder().decode([Beer].self, from: data) else {
                completion([])
                return
            }
            completion(response)
        }
        task.resume()
    }
    
    func getRandomBeer(completion: @escaping ([Beer]) -> ()) {
        let request = URLRequest(url: URL(string: "https://api.punkapi.com/v2/beers/random")!)
        let task = session.dataTask(with: request) { (data, _, _) in
            guard let data = data,
                  let response = try? JSONDecoder().decode([Beer].self, from: data) else {
                completion([])
                return
            }
            completion(response)
        }
        task.resume()
    }
}
