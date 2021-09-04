//
//  SeatView.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import UIKit

class SeatView: UIButton {
    var position: SeatPosition
    var price: Float
    
    init(position: SeatPosition, enable: Bool = true, price: Float) {
        self.position = position
        self.price = price
        super.init(frame: CGRect.zero)
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.layer.cornerRadius = 5
        self.contentMode = .scaleAspectFit
        self.isEnabled = enable
        self.backgroundColor = !enable ? UIColor.fromRGB(rgbValue: 0xC1C1C1) : UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            self.didSelected(self.isSelected)
        }
    }
    
    func didSelected(_ selected: Bool) {
        self.backgroundColor = selected ? UIColor.black : UIColor.fromRGB(rgbValue: 0xF8F8F8)
    }
    
    func didOccupied() {
        self.isEnabled = false
        self.backgroundColor = UIColor.fromRGB(rgbValue: 0xC1C1C1)
        self.layer.borderWidth = 1
        self.layoutIfNeeded()
    }
}

class StandardSeatView: SeatView {
    override init(position: SeatPosition, enable: Bool = true, price: Float) {
        super.init(position: position, enable: enable, price: price)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didSelected(_ selected: Bool) {
        if selected {
            self.backgroundColor = UIColor.black
        } else {
            self.backgroundColor = UIColor.clear
        }
    }
}

class OccupiedSeatView: SeatView {
    init(position: SeatPosition) {
        super.init(position: position, enable: false, price: 0)
        self.isEnabled = false
        self.backgroundColor = UIColor.fromRGB(rgbValue: 0xC1C1C1)
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class NotBookableSeatView: SeatView {
    init(position: SeatPosition) {
        super.init(position: position, enable: false, price: 0)
        self.isEnabled = false
        self.setBackgroundImage(UIImage(named: "not_bookable"), for: .normal)
        self.setBackgroundImage(UIImage(named: "not_bookable"), for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VipSeatView: SeatView {
    override init(position: SeatPosition, enable: Bool, price: Float) {
        super.init(position: position, enable: enable, price: price)
        self.layer.borderColor = UIColor.fromRGB(rgbValue: 0xEC4F4B).cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ReclinerSeatView: SeatView {
    override init(position: SeatPosition, enable: Bool, price: Float) {
        super.init(position: position, enable: enable, price: price)
        self.layer.borderColor = UIColor.fromRGB(rgbValue: 0xEC4F4B).cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class WheelChairSeatView: SeatView {
    init(position: SeatPosition) {
        super.init(position: position, enable: false, price: 0)
        self.backgroundColor = UIColor.clear
        self.tintColor = UIColor.fromRGB(rgbValue: 0x82B2D1)
        self.setBackgroundImage(UIImage(named: "wheel_chair")?.withTintColor(UIColor.fromRGB(rgbValue: 0x82B2D1)), for: .normal)
        self.setBackgroundImage(UIImage(named: "wheel_chair")?.withTintColor(UIColor.fromRGB(rgbValue: 0x82B2D1)), for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
