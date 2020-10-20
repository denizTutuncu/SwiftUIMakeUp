//
//  Webservice.swift
//  SwiftUIMakeUp
//
//  Created by Deniz Tutuncu on 10/19/20.
//

import Foundation

class Webservice {
    
    fileprivate let baseURL = URL(string: "http://makeup-api.herokuapp.com/api/v1")
    
    func fetchMakeup(queryBrand: String, completion: @escaping ([MakeUp]?) -> Void) {
        
        guard let unwrappedUrl = baseURL else { completion([]); return }
        let secondUrl = unwrappedUrl.appendingPathComponent("products").appendingPathExtension("json")
        print(secondUrl)
        var components = URLComponents(url: secondUrl, resolvingAgainstBaseURL: true)
        let brandQuery = URLQueryItem(name: "brand", value: queryBrand.lowercased())
        components?.queryItems = [brandQuery]
        
        guard let componentsUrl = components?.url else { completion([]); return }
        var request = URLRequest(url: componentsUrl)
        request.httpMethod = "GET"
        print(request)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("\(error.localizedDescription): \(error) in function \(#function)")
                completion([])
                return
            }
            guard let data = data else { completion([]); return}
            do {
                let jd = JSONDecoder()
                let makeup = try jd.decode([MakeUp].self, from: data)
                
                completion(makeup)
            } catch {
                print("\(error.localizedDescription): \(error) in function \(#function)")
                completion([])
                return
            }
            }.resume()
    }
}
