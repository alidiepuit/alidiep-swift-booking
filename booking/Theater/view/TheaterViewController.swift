//
//  SelectSeatViewController.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import UIKit
import SnapKit

class TheaterViewController: UIViewController, TheaterPresenterOutputProtocol {
    struct Const {
        
    }
    var presenter: TheaterPresenterInputProtocol?
    
    var theater: TheaterModel?
    
    var listSelectedSeat: [SeatView] = []
    
    private let imageScreen: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.fromRGB(rgbValue: 0xF8F8F8)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 5.0
        view.layer.masksToBounds = false
        return view
    }()
    
    private let loadingView = UIActivityIndicatorView()
    
    private let scrollView = UIScrollView()
    private let containerScrollView = UIView()
    
    private let titleScreen = UILabel()
    
    private let containerSeat = UIView()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private let seatingKey: UILabel = {
        let label = UILabel()
        label.text = "SEATING KEY"
        return label
    }()
    
    private let containerSeatLabel = UIView()
    
    private let containerLeft = UIView()
    private let containerRight = UIView()
    
    private let nextBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Next", for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.textColor = UIColor.white
        return button
    }()
    
    private let totalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    private let listSeatLabel = UILabel()
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
        self.presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func initLayout() {
        self.view.addSubview(self.imageScreen)
        self.view.addSubview(self.titleScreen)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.containerScrollView)
        self.containerScrollView.addSubview(self.containerSeat)
        self.containerScrollView.addSubview(self.line)
        self.containerScrollView.addSubview(self.seatingKey)
        self.containerScrollView.addSubview(self.containerSeatLabel)
        self.containerScrollView.addSubview(self.containerLeft)
        self.containerScrollView.addSubview(self.containerRight)
        self.view.addSubview(self.totalView)
        self.totalView.addSubview(self.listSeatLabel)
        self.totalView.addSubview(self.totalLabel)
        self.view.addSubview(self.nextBtn)
        self.view.addSubview(self.loadingView)
        self.loadingView.isHidden = true
        self.initTheaterView()
        self.view.backgroundColor = UIColor.white
        self.titleScreen.text = "Screen 4"
        self.nextBtn.addTarget(self, action: #selector(self.didTapNext), for: .touchUpInside)
        self.view.backgroundColor = UIColor.fromRGB(rgbValue: 0xF8F8F8)
    }
    
    func initTheaterView() {
        self.loadingView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.imageScreen.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        self.titleScreen.snp.remakeConstraints { make in
            make.center.equalTo(self.imageScreen)
        }
        self.scrollView.snp.remakeConstraints { make in
            make.top.equalTo(self.imageScreen.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.nextBtn.snp.top).offset(-20)
        }
        self.containerScrollView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.containerLeft.snp.bottom)
            make.bottom.equalToSuperview()
        }
        self.containerSeat.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(20)
        }
        self.line.snp.remakeConstraints { make in
            make.top.equalTo(self.containerSeat.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        self.seatingKey.snp.remakeConstraints { make in
            make.top.equalTo(self.line.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        self.containerSeatLabel.snp.remakeConstraints { make in
            make.top.bottom.equalTo(self.containerSeat)
            make.trailing.equalTo(self.containerSeat.snp.leading).offset(-5)
            make.width.equalTo(20)
        }
        self.containerLeft.snp.remakeConstraints { make in
            make.top.equalTo(self.seatingKey.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(150)
        }
        self.containerRight.snp.remakeConstraints { make in
            make.top.equalTo(self.seatingKey.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(150)
            make.bottom.equalTo(self.containerScrollView)
        }
        let seat = StandardSeatView(position: SeatPosition(x: 0, y: 0), price: 0)
        seat.isSelected = true
        let leftViewSeat = [
            seat,
            OccupiedSeatView(position: SeatPosition(x: 0, y: 0)),
            StandardSeatView(position: SeatPosition(x: 0, y: 0), price: 0),
            NotBookableSeatView(position: SeatPosition(x: 0, y: 0))
        ]
        let leftTextSeat = [
            "Your seat",
            "Occupied seat",
            "Standard seat",
            "Not Bookable seat"
        ]
        self.addItemToContainer(self.containerLeft, listView: leftViewSeat, listText: leftTextSeat)
        
        let rightViewSeat = [
            VipSeatView(position: SeatPosition(x: 0, y: 0), enable: true, price: 0),
            ReclinerSeatView(position: SeatPosition(x: 0, y: 0), enable: true, price: 0),
            WheelChairSeatView(position: SeatPosition(x: 0, y: 0))
        ]
        let rightTextSeat = [
            "VIP seat",
            "The  Recliner",
            "Wheelchair space"
        ]
        self.addItemToContainer(self.containerRight, listView: rightViewSeat, listText: rightTextSeat)
        self.nextBtn.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
        }
        self.totalView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalTo(self.nextBtn)
        }
        self.listSeatLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        self.totalLabel.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        self.totalLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func addItemToContainer(_ container: UIView, listView: [UIView], listText: [String]) {
        guard listView.count == listText.count else {
            return
        }
        for i in 0..<listView.count {
            let y = 30 * CGFloat(i)
            container.addSubview(listView[i])
            listView[i].snp.remakeConstraints { make in
                make.top.equalTo(y)
                make.leading.equalToSuperview().offset(20)
                make.width.height.equalTo(20)
            }
            let label = UILabel()
            label.text = listText[i]
            label.adjustsFontSizeToFitWidth = true
            label.sizeToFit()
            container.addSubview(label)
            label.snp.remakeConstraints { make in
                make.leading.equalTo(listView[i].snp.trailing).offset(10)
                make.centerY.equalTo(listView[i])
            }
        }
    }
    
    func didLoadSeats(theater: TheaterModel) {
        self.theater = theater
        if let theater = self.theater {
            let alpha = self.containerSeat.frame.width / CGFloat(theater.cols)
            let width = alpha - CGFloat(5)
            for seat in theater.seats {
                let x = alpha * CGFloat(seat.position.x)
                let y = alpha * CGFloat(seat.position.y)
                self.containerSeat.addSubview(seat)
                seat.snp.remakeConstraints { make in
                    make.leading.equalToSuperview().offset(x)
                    make.top.equalToSuperview().offset(y)
                    make.width.height.equalTo(width)
                }
                seat.addTarget(self, action: #selector(didTapSeat(_:)), for: .touchUpInside)
            }
            self.containerSeat.snp.updateConstraints { make in
                make.height.equalTo(alpha * CGFloat(theater.rows))
            }
            for y in 0..<theater.rows {
                let position = SeatPosition(x: 0, y: y)
                let y = alpha * CGFloat(y)
                let cell = UIView()
                self.containerSeatLabel.addSubview(cell)
                cell.snp.remakeConstraints { make in
                    make.leading.equalToSuperview().offset(0)
                    make.top.equalToSuperview().offset(y)
                    make.width.equalToSuperview()
                    make.height.equalTo(width)
                }
                let label = UILabel()
                label.text = position.getLetter
                label.adjustsFontSizeToFitWidth = true
                label.sizeToFit()
                cell.addSubview(label)
                label.snp.remakeConstraints { make in
                    make.center.equalToSuperview()
                }
            }
        }
    }
    
    @objc func didTapSeat(_ sender: UIButton) {
        if let sender = sender as? SeatView {
            self.presenter?.didTapSeat(seat: sender, isSelected: !sender.isSelected)
            self.loadingView.isHidden = false
            self.loadingView.startAnimating()
        }
    }
    
    @objc func didTapNext() {
        self.presenter?.didTapNext(listSeat: listSelectedSeat)
    }
    
    func didSelectedSeatSuccess(_ seat: SeatView, isSelected: Bool) {
        self.loadingView.isHidden = true
        self.loadingView.stopAnimating()
        guard let sender = self.theater?.seats.first(where: { view in
            return view.position == seat.position
        }) else { return }
        sender.isSelected = isSelected
        if sender.isSelected {
            self.listSelectedSeat.append(sender)
        } else {
            if let idx = self.listSelectedSeat.firstIndex(where: { seat in
                return seat.position.x == sender.position.x && seat.position.y == sender.position.y
            }) {
                self.listSelectedSeat.remove(at: idx)
            }
        }
        if self.listSelectedSeat.count > 0 {
            self.listSeatLabel.text = ""
            self.listSelectedSeat.forEach { seat in
                self.listSeatLabel.text = "\(self.listSeatLabel.text!.isEmpty ? "" : self.listSeatLabel.text! + ",")\(seat.position.getSeat)"
            }
            let price = self.listSelectedSeat.reduce(0) { result, seat in
                return result + seat.price
            }
            self.totalLabel.text = "Total: \(price)"
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.totalView.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(50)
                    make.bottom.equalTo(self.nextBtn.snp.top)
                }
                self.view.layoutIfNeeded()
            } completion: { _ in
            }
        } else {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.totalView.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(50)
                    make.bottom.equalTo(self.nextBtn)
                }
                self.view.layoutIfNeeded()
            } completion: { _ in
            }
        }
    }
    
    func didSelectedSeatFail(position: SeatPosition, error: Error) {
        self.loadingView.isHidden = true
        self.loadingView.stopAnimating()
        
        if let seat = self.theater?.seats.first(where: { view in
            return view.position == position
        }) {
            seat.didOccupied()
        }
        
        let alertView = UIAlertController(title: nil, message: "This seat is not available.", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        self.present(alertView, animated: true, completion: nil)
    }
}
