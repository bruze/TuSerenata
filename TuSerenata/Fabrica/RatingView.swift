//
//  RatingView.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/13/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
struct some {
    var memb: Int = 8 {
        didSet {
            memb = 0
        }
    }
}
class RatingButton {
    var button: UIButton!
    var previousSibling: RatingButton? {
        didSet {
            previousSibling!.nextSibling = self
        }
    }
    var nextSibling: RatingButton?
    init(idleImageName:String, selectedImageName: String, button: UIButton) {
        self.button = button
        button.setImage(UIImage(named: idleImageName), for: .normal)
        button.setImage(UIImage(named: selectedImageName), for: .highlighted)
        button.setImage(UIImage(named: selectedImageName), for: .selected)
    }
}

class RatingView: UIView {
    var rating: Int {
        var result = 0
        for button in ratingButtons {
            if button.button.isSelected {
                result += 1
            }
        }
        return result
    }
    fileprivate let ratingItemsNumber = 5
    fileprivate let ratingItemsSeparation = 30
    fileprivate var ratingButtons: [RatingButton] = []

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame: CGRect, idleImageName: String, selectedImageName: String) {
        super.init(frame: frame)
        for i in 0..<ratingItemsNumber {
            let newButton = UIButton.init(x: CGFloat(10+(i*ratingItemsSeparation)), y: 15, w: 30, h: 30, target: self, action: #selector(RatingView.updateRating))
            let newRatingButton = RatingButton.init(idleImageName: idleImageName, selectedImageName: selectedImageName, button: newButton)
            ratingButtons.append(newRatingButton)
            addSubview(newRatingButton.button)
            if i>0 {
                newRatingButton.previousSibling = ratingButtons[i-1]
            }
        }
    }

    func selectNextSiblings(button: RatingButton, select: Bool) {
        var nextSibling = button.nextSibling
        while nextSibling != nil {
            nextSibling?.button.isSelected = select
            nextSibling = nextSibling?.nextSibling
        }
    }

    func selectPreviousSiblings(button: RatingButton, select: Bool) {
        var prevSibling = button.previousSibling
        while prevSibling != nil {
            prevSibling?.button.isSelected = select
            prevSibling = prevSibling?.previousSibling
        }
    }

    func getRatingItemFrom(button: UIButton) -> RatingButton? {
        for ratingButton in ratingButtons {
            if ratingButton.button == button {
                return ratingButton
            }
        }
        return nil
    }

    func updateRating(_ button: UIButton) {
        if let ratingButton = getRatingItemFrom(button: button) {
            if button.isSelected && ratingButton.previousSibling == nil {
                if rating == 1 {
                    button.isSelected = false
                }
            } else {
                button.isSelected = true
                selectPreviousSiblings(button: ratingButton, select: button.isSelected)
            }
            selectNextSiblings(button: ratingButton, select: false)
        }
        print(rating)
    }
}
