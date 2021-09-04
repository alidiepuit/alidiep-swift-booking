//
//  APIClient.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    func getTheater(success: @escaping (TheaterModel?) -> Void, failure: (Error) -> Void)
}

class APIClient: APIClientProtocol {
    func getTheater(success: @escaping (TheaterModel?) -> Void, failure: (Error) -> Void) {
        AF.request("https://httpbin.org/get").responseDecodable(of: TheaterModel.self) { response in
            debugPrint("Response: \(response)")
            success(response.value)
        }
    }
}
