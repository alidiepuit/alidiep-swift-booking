//
//  BookingManager.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

protocol BookingManagerProtocol {
    func getTheater(success: @escaping (TheaterModel?) -> Void, failure: (Error) -> Void)
}

class BookingManager: BookingManagerProtocol {
    private let api: APIClientProtocol
    
    public static let shared = BookingManager(api: APIClient())
    
    init(api: APIClientProtocol) {
        self.api = api
    }
    
    func getTheater(success: @escaping (TheaterModel?) -> Void, failure: (Error) -> Void) {
        self.api.getTheater { theater in
            success(theater)
        } failure: { (_) in
            
        }
    }
}
