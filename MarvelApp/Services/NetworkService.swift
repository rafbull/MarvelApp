//
//  NetworkService.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class NetworkService: NSObject, NetworkServiceProtocol {
    // MARK: - Private Properties
    private let imageCache: NSCache<NSURL, UIImage> = {
        let imageCache = NSCache<NSURL, UIImage>()
        imageCache.countLimit = 50
        return imageCache
    }()
    private let dataCache = NSCache<NSURL, NSData>()
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()
    
    // MARK: - Internal Methods
    func fetch<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<BaseResponseDTO<T>, Error>) -> Void) {
        let urlString = endpoint.absoluteURL()
        
        guard let url = URL(string: urlString)
        else {
            completion(.failure(FetchError.badURL))
            return
        }
        
        if let cachedData = dataCache.object(forKey: url as NSURL) {
            do {
                let decodedData = try decoder.decode(BaseResponseDTO<T>.self, from: cachedData as Data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(FetchError.decodingFailed(error)))
            }
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(FetchError.requestFailed(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(FetchError.badURL))
                return
            }
            
            if let badStatusCodeError = self?.checkResponseStatusCode(response.statusCode) {
                completion(.failure(badStatusCodeError))
                return
            }
            
            guard let data = data
            else {
                completion(.failure(FetchError.noData))
                return
            }
            
            do {
                guard let decodedData = try self?.decoder.decode(BaseResponseDTO<T>.self, from: data) else {
                    completion(.failure(FetchError.decodingFailed(URLError(.cannotDecodeRawData))))
                    return
                }
                self?.dataCache.setObject(data as NSData, forKey:  url as NSURL)
                completion(.success(decodedData))
            } catch {
                completion(.failure(FetchError.decodingFailed(error)))
            }
        }
        task.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        var componentsURL = URLComponents(string: urlString)
        componentsURL?.scheme = "https"
        
        guard let secureURL = componentsURL?.url
        else {
            completion(.failure(FetchError.badURL))
            return
        }
        
        if let cachedImage = imageCache.object(forKey: secureURL as NSURL) {
            completion(.success(cachedImage))
            return
        }
        
        let task = session.dataTask(with: secureURL) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(FetchError.requestFailed(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(FetchError.badURL))
                return
            }
            
            if let badStatusCodeError = self?.checkResponseStatusCode(response.statusCode) {
                completion(.failure(badStatusCodeError))
                return
            }
            
            guard let data = data, let image = UIImage(data: data)
            else {
                completion(.failure(FetchError.noData))
                return
            }
            self?.imageCache.setObject(image, forKey:  secureURL as NSURL)
            completion(.success(image))
        }
        task.resume()
    }
}

private extension NetworkService {
    func checkResponseStatusCode(_ statusCode: Int) -> Error? {
        switch statusCode {
        case 200...299:
            break
        case 300...399:
            return FetchError.redirection(statusCode: statusCode)
        case 400...499:
            let message = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            return FetchError.clientError(statusCode: statusCode, message: message)
        case 500...599:
            let message = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            return FetchError.serverError(statusCode: statusCode, message: message)
        default:
            break
        }
        return nil
    }
}
