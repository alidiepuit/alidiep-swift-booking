//
//  SelectSeatProtocol.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

protocol SelectSeatViewInputProtocol: AnyObject {
    var presenter: SelectSeatPresenterInputProtocol { get set }
}

protocol SelectSeatPresenterInputProtocol: AnyObject {
    var view: SelectSeatPresenterOutputProtocol? { get set }
    var interactor: SelectSeatInteractorInputProtocol? { get set }
    
    func viewDidLoad()
}

protocol SelectSeatPresenterOutputProtocol: AnyObject {
    func didLoadSeats(theater: TheaterModel?)
}

protocol SelectSeatInteractorInputProtocol: AnyObject {
    var presenter: SelectSeatInteractorOutputProtocol? { get set }
    
    func loadSeats()
}

protocol SelectSeatInteractorOutputProtocol: AnyObject {
    func didLoadSeats(theater: TheaterModel?)
}
