//
//  UIView+Extension.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit

//MARK: - Pin Top -
extension UIView {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    /**
     Pins view's topAnchor to target's bottomAnchor, if not provided it pins to superview's topAnchor
     
     - parameter offset: default value is 0.0.
     - parameter target: target view to be pin.
     - returns: NSLayoutConstraint?
     `
     */
    @discardableResult
    func pinTop(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        pin(offset, target: target, anchor: .top)
    }
    
    /**
     Pins view's topAnchor to target's bottomAnchor, if not provided it pins to superview's topAnchor
     
     - parameter offset: default value is 0.0.
     - parameter target: target view to be pin.
     - returns: NSLayoutConstraint?
     `
     */
    @discardableResult
    func pinSafeTop(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        pinSafe(offset, target: target, anchor: .top)
    }
}
//MARK: - Pin Left -
extension UIView {
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        } else {
            return self.leftAnchor
        }
    }
    /**
     Pins view's leftAnchor to target's rightAnchor, if not provided it pins to superview's leftAnchor
     
     - parameter offset: default value is 0.0.
     - parameter target: target view to be pin.
     - returns: NSLayoutConstraint?
     
     */
    @discardableResult
    func pinLeft(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        pin(offset, target: target, anchor: .left)
    }
    
    /**
     Pins view's leftAnchor to target's rightAnchor, if not provided it pins to superview's leftAnchor
     
     - parameter offset: default value is 0.0.
     - parameter target: target view to be pin.
     - returns: NSLayoutConstraint?
     
     */
    @discardableResult
    func pinSafeLeft(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        pinSafe(offset, target: target, anchor: .left)
    }
}
//MARK: - Pin Right -
extension UIView {
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        } else {
            return self.rightAnchor
        }
    }
    /**
     Pins view's rightAnchor to target's leftAnchor, if not provided it pins to superview's rightAnchor
     
     - parameter offset: default value is 0.0.
     - parameter target: target view to be pin.
     - returns: NSLayoutConstraint?
     
     */
    @discardableResult
    func pinRight(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        pin(offset, target: target, anchor: .right)
    }
    
    /**
     Pins view's rightAnchor to target's leftAnchor, if not provided it pins to superview's rightAnchor
     
     - parameter offset: default value is 0.0.
     - parameter target: target view to be pin.
     - returns: NSLayoutConstraint?
     
     */
    @discardableResult
    func pinSafeRight(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        pinSafe(offset, target: target, anchor: .right)
    }
}

//MARK: - Pin Bottom -
extension UIView {
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
    /**
     Pins view's bottomAnchor to target's topAnchor, if not provided it pins to superview's bottomAnchor.
     
     - parameter offset: default value is 0.0.
     - parameter target: target view to be pin.
     - returns: NSLayoutConstraint?
     
     */
    @discardableResult
    func pinBottom(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        pin(offset, target: target, anchor: .bottom)
    }
    
    /**
     Pins view's bottomAnchor to target's topAnchor, if not provided it pins to superview's bottomAnchor.
     
     - parameter offset: default value is 0.0.
     - parameter target: target view to be pin.
     - returns: NSLayoutConstraint?
     
     */
    @discardableResult
    func pinSafeBottom(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        pinSafe(offset, target: target, anchor: .bottom)
    }
}
//MARK: - Width Height Constraints -
extension UIView {
    /**
     Set view's height
     
     - parameter size: height size.
     - parameter comparator: comparator like equal, greater or smaller.
     - returns: NSLayoutConstraint?
     
     # Example #
     ```
     // view.height(with: 20, .equalToConstant)
     ```
     */
    @discardableResult
    func height(with size: CGFloat, comparator: Comprator) -> NSLayoutConstraint? {
        self.prepareForConstraints()
        var constraint: NSLayoutConstraint?
        
        if comparator == .equalToConstant {
            constraint = self.heightAnchor.constraint(equalToConstant: size)
        } else if comparator == .greaterThanOrEqualToConstant {
            constraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: size)
        } else if comparator == .lessThanOrEqualToConstant {
            constraint = self.heightAnchor.constraint(lessThanOrEqualToConstant: size)
        }
        
        constraint?.isActive = true
        return constraint
    }
    /**
     Set view's height
     
     - parameter size: height size.
     - parameter toAnchor: target's anchor.
     - parameter multiplier: default value is 1.0.
     - parameter comparator: comparator like equal, greater or smaller.
     - returns: NSLayoutConstraint?
     
     # Example #
     ```
     // view.height(toAnchor: view.leftAnchor, multiplier: 0.5)
     ```
     */
    @discardableResult
    func height(with size: CGFloat, toAnchor: NSLayoutDimension, multiplier: CGFloat = 1, comparator: Comprator) -> NSLayoutConstraint? {
        self.prepareForConstraints()
        var constraint: NSLayoutConstraint?
        
        if comparator == .equalToConstant {
            constraint = self.heightAnchor.constraint(equalTo: toAnchor, multiplier: multiplier, constant: size)
        } else if comparator == .greaterThanOrEqualToConstant {
            constraint = self.heightAnchor.constraint(greaterThanOrEqualTo: toAnchor, multiplier: multiplier, constant: size)
        } else if comparator == .lessThanOrEqualToConstant {
            constraint = self.heightAnchor.constraint(lessThanOrEqualTo: toAnchor, multiplier: multiplier, constant: size)
        }
        
        constraint?.isActive = true
        return constraint
    }
    /**
     Set view's width
     
     - parameter size: width size.
     - parameter comparator: comparator like equal, greater or smaller.
     - returns: NSLayoutConstraint?
     
     # Example #
     ```
     // view.width(with: 20, .equalToConstant)
     ```
     */
    @discardableResult
    func width(with size: CGFloat, comparator: Comprator) -> NSLayoutConstraint? {
        self.prepareForConstraints()
        var constraint: NSLayoutConstraint?
        
        if comparator == .equalToConstant {
            constraint = self.widthAnchor.constraint(equalToConstant: size)
        } else if comparator == .greaterThanOrEqualToConstant {
            constraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: size)
        } else if comparator == .lessThanOrEqualToConstant {
            constraint = self.widthAnchor.constraint(lessThanOrEqualToConstant: size)
        }
        
        constraint?.isActive = true
        return constraint
    }
    /**
     Set view's width
     
     - parameter size: wdith size.
     - parameter toAnchor: target's anchor.
     - parameter multiplier: default value is 1.0.
     - parameter comparator: comparator like equal, greater or smaller.
     - returns: NSLayoutConstraint?
     
     # Example #
     ```
     // view.width(toAnchor: view.leftAnchor, multiplier: 0.5)
     ```
     */
    @discardableResult
    func width(with size: CGFloat, toAnchor: NSLayoutDimension, multiplier: CGFloat = 1, comparator: Comprator) -> NSLayoutConstraint? {
        self.prepareForConstraints()
        var constraint: NSLayoutConstraint?
        
        if comparator == .equalToConstant {
            constraint = self.widthAnchor.constraint(equalTo: toAnchor, multiplier: multiplier, constant: size)
        } else if comparator == .greaterThanOrEqualToConstant {
            constraint = self.widthAnchor.constraint(greaterThanOrEqualTo: toAnchor, multiplier: multiplier, constant: size)
        } else if comparator == .lessThanOrEqualToConstant {
            constraint = self.widthAnchor.constraint(lessThanOrEqualTo: toAnchor, multiplier: multiplier, constant: size)
        }
        
        constraint?.isActive = true
        return constraint
    }
}
//MARK: - Pin Edges -
extension UIView {
    func pinEdgesToSuperview(_ offset: CGFloat = 0.0) {
        self.pinTop(offset)
        self.pinBottom(offset)
        self.pinRight(offset)
        self.pinLeft(offset)
    }
    
    func pinEdgesHorizontallyToSuperview(_ offset: CGFloat = 0.0) {
        self.pinRight(offset)
        self.pinLeft(offset)
    }
    
    func pinEdgesVerticallyToSuperview(_ offset: CGFloat = 0.0) {
        self.pinTop(offset)
        self.pinBottom(offset)
    }
}
//MARK: - Pin Vertically -
extension UIView {
    @discardableResult
    func centerVerticallyToSuperView(_ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        self.prepareForConstraints()
        guard let superview = self.superview else {
            return nil
        }
        
        let constraint = self.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    /**
     Center view vertically to YAxisAnchor.
     */
    @discardableResult
    func pinCenterVerticallyInRelation(to anchor:NSLayoutYAxisAnchor, _ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        self.prepareForConstraints()
        let constraint = self.centerYAnchor.constraint(equalTo: anchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
}
//MARK: - Pin Horizontally -
extension UIView {
    @discardableResult
    func centerHorizontallyToSuperView(_ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        self.prepareForConstraints()
        guard let superview = self.superview else {
            return nil
        }
        let constraint = self.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset)
        constraint.isActive = true
        return constraint
        
    }
    /**
     Center view horizontally to xAxisAnchor.
     */
    @discardableResult
    func pinCenterHorizontallyInRelation(to anchor:NSLayoutXAxisAnchor, _ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        self.prepareForConstraints()
        let constraint = self.centerXAnchor.constraint(equalTo: anchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
}

//MARK: - Other Constraints -
extension UIView {
    /**
     Set widthAnchor equal to heightAnchor.
     */
    @discardableResult
    func squareViewConstraint() -> NSLayoutConstraint? {
        self.prepareForConstraints()
        let constraint = self.widthAnchor.constraint(equalTo: self.heightAnchor)
        constraint.isActive = true
        return constraint
    }
    /**
     Round view with radius.
    
     - parameter radius: if radius not provided then it will be view's height / 2.
     */
    func roundView(_ radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.height / 2.0
        self.clipsToBounds = true
    }
    
    /// Set an aspect ratio constraint with the given ratio, where ratio
    /// is Width / Height.
    ///
    /// - Parameter ratio: The ratio for the constraint
    @discardableResult
    func aspectRatio(_ ratio: CGFloat) -> NSLayoutConstraint? {
        self.prepareForConstraints()
        let constraint = self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: ratio)
        constraint.isActive = true
        return constraint
    }
}

//MARK: - Setup and utility fucntions -
extension UIView {
    fileprivate enum Anchor {
        case top
        case bottom
        case left
        case right
    }
    enum Comprator {
        case equalToConstant
        case lessThanOrEqualToConstant
        case greaterThanOrEqualToConstant
    }
    
    fileprivate func prepareForConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    /**
     Pins view to a target based on it's anchor's value. If target is nil it pins to it's superview based on anchor's value
     
     - parameter offset: default value is 0.0.
     - parameter target: target view to be pin.
     - parameter anchor: layout anchor Ex. .left, .right, .top, .bottom.
     - returns: NSLayoutConstraint?
     
     # Example #
     ```
     // pin(5, target: view, anchor: .top)
     ```
     
     */
    fileprivate func pin(_ offset: CGFloat, target: UIView? = nil, anchor: Anchor) -> NSLayoutConstraint? {
        prepareForConstraints()
        guard let superview = self.superview else {
            return nil
        }
        var constraint: NSLayoutConstraint?
        
        switch anchor {
        case .bottom:
            if let target = target {
                constraint = self.bottomAnchor.constraint(equalTo: target.topAnchor, constant: -offset)
            } else {
                constraint = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -offset)
            }
        case .top:
            if let target = target {
                constraint = self.topAnchor.constraint(equalTo: target.bottomAnchor, constant: offset)
            } else {
                constraint = self.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset)
            }
        case .left:
            if let target = target {
                constraint = self.leftAnchor.constraint(equalTo: target.rightAnchor, constant: offset)
            } else {
                constraint = self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset)
            }
        case .right:
            if let target = target {
                constraint = self.rightAnchor.constraint(equalTo: target.leftAnchor, constant: -offset)
            } else {
                constraint = self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -offset)
            }
        }
        
        constraint?.isActive = true
        return constraint
    }
    fileprivate func pinSafe(_ offset: CGFloat, target: UIView? = nil, anchor: Anchor) -> NSLayoutConstraint? {
        prepareForConstraints()
        guard let superview = self.superview else {
            return nil
        }
        var constraint: NSLayoutConstraint?
        
        switch anchor {
        case .bottom:
            if let target = target {
                constraint = self.bottomAnchor.constraint(equalTo: target.safeTopAnchor, constant: -offset)
            } else {
                constraint = self.bottomAnchor.constraint(equalTo: superview.safeBottomAnchor, constant: -offset)
            }
        case .top:
            if let target = target {
                constraint = self.topAnchor.constraint(equalTo: target.safeBottomAnchor, constant: offset)
            } else {
                constraint = self.topAnchor.constraint(equalTo: superview.safeTopAnchor, constant: offset)
            }
        case .left:
            if let target = target {
                constraint = self.leftAnchor.constraint(equalTo: target.safeRightAnchor, constant: offset)
            } else {
                constraint = self.leftAnchor.constraint(equalTo: superview.safeLeftAnchor, constant: offset)
            }
        case .right:
            if let target = target {
                constraint = self.rightAnchor.constraint(equalTo: target.safeLeftAnchor, constant: -offset)
            } else {
                constraint = self.rightAnchor.constraint(equalTo: superview.safeRightAnchor, constant: -offset)
            }
        }
        
        constraint?.isActive = true
        return constraint
    }
    func removeAllConstraints() {
        for subview in self.subviews {
            subview.removeAllConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}
