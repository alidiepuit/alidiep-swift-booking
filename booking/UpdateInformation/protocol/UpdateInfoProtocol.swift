//
//  UpdateInfoProtocol.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import Foundation

protocol UpdateInfoViewInputProtocol: AnyObject {
    var presenter: UpdateInfoPresenterInputProtocol { get set }
}

protocol UpdateInfoPresenterInputProtocol: AnyObject {
    var view: UpdateInfoPresenterOutputProtocol? { get set }
    var interactor: UpdateInfoInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    func didTapSubmit(userInfo: UserInfoModel)
}

protocol UpdateInfoPresenterOutputProtocol: AnyObject {
    func didBookingSuccess()
    func didBookingFail(message: String)
}

protocol UpdateInfoInteractorInputProtocol: AnyObject {
    var presenter: UpdateInfoInteractorOutputProtocol? { get set }
    
    func booking(positions: [SeatPosition], userInfo: UserInfoEntity)
}

protocol UpdateInfoInteractorOutputProtocol: AnyObject {
    func didBookingSuccess()
    func didBookingFail(message: String)
}
