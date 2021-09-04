//
//  SelectSeatProtocol.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import UIKit

protocol TheaterWireframeProtocol: AnyObject {
    func pushUpdateInfo(root: TheaterPresenterOutputProtocol, positions: [SeatPosition])
}

protocol TheaterPresenterInputProtocol: AnyObject {
    var view: TheaterPresenterOutputProtocol? { get set }
    var interactor: TheaterInteractorInputProtocol? { get set }
    var wireframe: TheaterWireframeProtocol? { get set }
    
    func viewDidLoad()
    func didTapNext(listSeat: [SeatView])
    func didTapSeat(seat: SeatView, isSelected: Bool)
}

protocol TheaterPresenterOutputProtocol: UIViewController {
    func didLoadSeats(theater: TheaterModel)
    func didSelectedSeatSuccess(_ sender: SeatView, isSelected: Bool)
    func didSelectedSeatFail(position: SeatPosition, error: Error)
}

protocol TheaterInteractorInputProtocol: AnyObject {
    var presenter: TheaterInteractorOutputProtocol? { get set }
    
    func loadSeats()
    func checkSeatAvailable(position: SeatPosition, isSelected: Bool)
}

protocol TheaterInteractorOutputProtocol: AnyObject {
    func didLoadSeats(theater: TheaterEntity?)
    func didCheckSeatAvailable(seat: SeatEntity?, isSelected: Bool)
    func didCheckSeatAvailableFail(position: SeatPosition, error: Error?)
}
