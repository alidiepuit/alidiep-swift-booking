//
//  APIClient.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    func setDefaultHeader(params: [String:String]?)
    func getTheater(success: @escaping (TheaterEntity?) -> Void, failure: @escaping (Error) -> Void)
    func checkAvailableSeat(position: SeatPosition, isSelected: Bool, success: @escaping (SeatEntity?, Bool) -> Void, failure: @escaping (Error) -> Void)
    func booking(positions: [SeatPosition], userInfo: UserInfoEntity, success: @escaping (Booking?) -> Void, failure: @escaping (Booking?) -> Void)
}

struct CloudBase: Codable {
    
}

struct CloudSeatAvailable: Codable {
    var seat: SeatEntity?
    var isSelected: Bool
}

struct Booking: Codable {
    var isSuccess: Bool
    var message: String
}

class APIClient: APIClientProtocol {
    
    private let sessionId = String.randomString(length: 10)
    
    public static var shared: APIClientProtocol = APIClient()
    
    private var client: Session!
    
    private let baseURL = "https://meteor-experienced-sneezeweed.glitch.me"
    
    func setDefaultHeader(params: [String:String]?) {
        var headers = HTTPHeaders()
        if let params = params {
            headers = HTTPHeaders(params)
        }
        headers.add(name: "id", value: self.sessionId)
        AF.session.configuration.headers = headers
        let configuration = URLSessionConfiguration.default
        var defaultHeaders = HTTPHeaders.default
        defaultHeaders["id"] = self.sessionId
        configuration.headers = defaultHeaders
        self.client = Alamofire.Session(configuration: configuration)
    }
    
    func getTheater(success: @escaping (TheaterEntity?) -> Void, failure: @escaping (Error) -> Void) {
        self.client.request(self.baseURL + "/theater")
            .validate(statusCode: 200..<400)
            .responseDecodable(of: TheaterEntity.self) { response in
            print("Response: \(response)")
            if let error = response.error {
                failure(error)
            } else {
                success(response.value)
            }
        }
    }
    func checkAvailableSeat(position: SeatPosition, isSelected: Bool, success: @escaping (SeatEntity?, Bool) -> Void, failure: @escaping (Error) -> Void) {
        self.client.request(self.baseURL + "/check-seat",
                   method: HTTPMethod.post,
                   parameters: [
                        "x": position.x,
                        "y": position.y,
                        "isSelected": isSelected
                    ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: CloudSeatAvailable.self) { response in
            print("Response: \(response)")
            if let error = response.error {
                failure(error)
            } else {
                success(response.value?.seat, response.value?.isSelected ?? false)
            }
        }
    }
    
    func booking(positions: [SeatPosition], userInfo: UserInfoEntity, success: @escaping (Booking?) -> Void, failure: @escaping (Booking?) -> Void) {
        let jsonDataPosition = try! JSONEncoder().encode(positions)
        let jsonStringPosition = String(data: jsonDataPosition, encoding: .utf8)!
        
        let jsonDataUserInfo = try! JSONEncoder().encode(userInfo)
        let jsonStringUserInfo = String(data: jsonDataUserInfo, encoding: .utf8)!
        
        self.client.request(self.baseURL + "/booking",
                   method: HTTPMethod.post,
                   parameters: [
                    "positions": jsonStringPosition,
                    "userInfo": jsonStringUserInfo
                   ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: Booking.self) { response in
            print("Response: \(response)")
            if let _ = response.error {
                if let data = response.data {
                    let booking = try? JSONDecoder().decode(Booking.self, from: data)
                    failure(booking)
                    return
                }
                failure(nil)
                return
            } else {
                success(response.value)
            }
        }
    }
}
