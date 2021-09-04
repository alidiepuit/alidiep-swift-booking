//
//  SeatView.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 04/09/2021.
//

import UIKit

class SeatView: UIButton {
    var position: SeatPosition
    
    init(position: SeatPosition) {
        self.position = position
        super.init(frame: CGRect.zero)
        self.roundCorners(corners: UIRectCorner.bottomLeft, radius: 5)
        self.roundCorners(corners: UIRectCorner.bottomRight, radius: 5)
        self.layer.masksToBounds = true
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
        
    }
}

class StandardSeatView: SeatView {
    override init(position: SeatPosition) {
        super.init(position: position)
        self.layer.borderColor = UIColor.black.cgColor
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
    override init(position: SeatPosition) {
        super.init(position: position)
        self.isEnabled = false
        self.backgroundColor = UIColor.gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class NotBookableSeatView: SeatView {
    override init(position: SeatPosition) {
        super.init(position: position)
        self.isEnabled = false
        self.setBackgroundImage(UIImage(named: "not_bookable"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VipSeatView: SeatView {
    override init(position: SeatPosition) {
        super.init(position: position)
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ReclinerSeatView: SeatView {
    override init(position: SeatPosition) {
        super.init(position: position)
        self.layer.borderColor = UIColor.systemPink.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class WheelChairSeatView: SeatView {
    override init(position: SeatPosition) {
        super.init(position: position)
        self.isEnabled = false
        self.tintColor = UIColor.blue
        self.setBackgroundImage(UIImage(named: "wheel_chair"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
