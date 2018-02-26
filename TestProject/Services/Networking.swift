//
//  Networking.swift
//  TestProject
//
//  Created by Admin on 2/25/18.
//  Copyright © 2018 Patel, Sanjay. All rights reserved.
//

import UIKit

class Networking {
    static func getImage(_ id: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: "https://photo.nemours.org/P/\(id)/100x100?type=P") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return
            }
            guard 200...205 ~= statusCode else {
                return
            }
            guard let data = data else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            completion(image)
        }.resume()
    }
}
