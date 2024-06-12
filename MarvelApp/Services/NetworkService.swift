//
//  NetworkService.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class NetworkService: NSObject, NetworkServiceProtocol {
    // MARK: - Private Properties
    private let imageCache = NSCache<NSURL, UIImage>()
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
            
            switch response.statusCode {
            case 200...299:
                break
            case 300...399:
                completion(.failure(FetchError.redirection(statusCode: response.statusCode)))
                return
            case 400...499:
                let message = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                completion(.failure(FetchError.clientError(statusCode: response.statusCode, message: message)))
                return
            case 500...599:
                let message = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                completion(.failure(FetchError.serverError(statusCode: response.statusCode, message: message)))
                return
            default:
                break
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
        
        guard let data = try? Data(contentsOf: secureURL), let image = UIImage(data: data) else {
            completion(.failure(FetchError.decodingFailed(URLError(.cannotDecodeRawData))))
            return
        }
        imageCache.setObject(image, forKey:  secureURL as NSURL)
        completion(.success(image))
    }
}
