//
//  ArticlesRepository.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
protocol ArticlesRepositoryProtocol {
    func getMostPopularArticles(endpoint: NYTimesEndpoint,completion: @escaping (Result<[DomainArticle], Error>) -> Void)
}

protocol ArticlesDataSourceProtocol {
    func fetchArticles(from endpoint: NYTimesEndpoint, completion: @escaping (Result<Data, Error>) -> Void)
}

class ArticlesRepository: ArticlesRepositoryProtocol {
    private let networkDataSource: ArticlesDataSourceProtocol
    private let localDataSource: ArticlesDataSourceProtocol?

    init(networkDataSource: ArticlesDataSourceProtocol = NYNetworkManager(),
         localDataSource: ArticlesDataSourceProtocol? = nil) {
        self.networkDataSource = networkDataSource
        self.localDataSource = localDataSource
    }

    func getMostPopularArticles(endpoint: NYTimesEndpoint, completion: @escaping (Result<[DomainArticle], Error>) -> Void) {
          // fetch from db else fetch from network
          if let localDataSource = localDataSource {
              localDataSource.fetchArticles(from: endpoint) { [weak self] result in
                  switch result {
                  case .success(let data):
                      if !data.isEmpty {
                        let parser = JSONDataParser<NYTResponse>()
                        self?.decodeArticles(from: data, parser: parser, completion: completion)
                      } else {
                          //If empty then fetch from network
                          self?.fetchFromNetwork(endpoint: endpoint, completion: completion)
                      }
        
                  case .failure:
                      //if fetch fails from db, fetch from network
                      self?.fetchFromNetwork(endpoint: endpoint, completion: completion)
                  }
              }
          } else {
              fetchFromNetwork(endpoint: endpoint, completion: completion)
          }
      }

    private func fetchFromNetwork(endpoint: NYTimesEndpoint, completion: @escaping (Result<[DomainArticle], Error>) -> Void) {
        networkDataSource.fetchArticles(from: endpoint) { [weak self] result in
              switch result {
              case .success(let data):
                  let parser = JSONDataParser<NYTResponse>()
                self?.decodeArticles(from: data, parser: parser, completion: completion)
                  //cache the fetched articles
                  // self?.cacheArticles(data: data)

              case .failure(let error):
                  completion(.failure(error))
              }
          }
      }
    
    private func decodeArticles<P: DataParser>(from data: Data, parser: P, completion: @escaping (Result<[DomainArticle], Error>) -> Void) where P.Output == NYTResponse {
        do {
            let response = try parser.parse(data: data)
            let domainArticles = response.results.map { $0.toDomainModel() }
            completion(.success(domainArticles))
        } catch {
            completion(.failure(error))
        }
    }

    // cache locally
        private func cacheArticles(data: Data) {
            //localDataSource?.saveArticles(data: data) //
        }
}

