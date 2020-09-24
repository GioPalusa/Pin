#if os(OSX)
    import AppKit
#elseif os(iOS) || os(tvOS)
    import UIKit
#endif

public struct LayoutPin {
    public let item: AnyObject
    public let attribute: NSLayoutConstraint.Attribute
    public var multiplier: CGFloat
    public var constant: CGFloat

    public init(item: AnyObject, attribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        self.item = item
        self.attribute = attribute
        self.multiplier = multiplier
        self.constant = constant
    }

    public func multiplied(by multiplier: CGFloat) -> LayoutPin {
        var new = self
        new.multiplier *= multiplier
        return new
    }

    public func offset(by constant: CGFloat) -> LayoutPin {
        var new = self
        new.constant += constant
        return new
    }

    public func equal(to other: LayoutPin) -> NSLayoutConstraint {
        return createConstraint(combining: other, relatedBy: .equal)
    }

    public func greaterThanOrEqual(to other: LayoutPin) -> NSLayoutConstraint {
        return createConstraint(combining: other, relatedBy: .greaterThanOrEqual)
    }

    public func lessThanOrEqual(to other: LayoutPin) -> NSLayoutConstraint {
        return createConstraint(combining: other, relatedBy: .lessThanOrEqual)
    }

    public func equal(to constant: CGFloat) -> NSLayoutConstraint {
        return createConstraint(withConstant: constant, relatedBy: .equal)
    }

    public func greaterThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        return createConstraint(withConstant: constant, relatedBy: .greaterThanOrEqual)
    }

    public func lessThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        return createConstraint(withConstant: constant, relatedBy: .lessThanOrEqual)
    }
}

internal extension LayoutPin {
    func createConstraint(combining other: LayoutPin, relatedBy relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self.item,
            attribute: attribute,
            relatedBy: relation,
            toItem: other.item,
            attribute: other.attribute,
            multiplier: other.multiplier,
            constant: other.constant
        )
    }

    func createConstraint(withConstant constant: CGFloat, relatedBy relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self.item,
            attribute: attribute,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: constant
        )
    }
}

public func == (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

public func <= (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

public func >= (lhs: LayoutPin, rhs: LayoutPin) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

public func == (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

public func <= (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

public func >= (lhs: LayoutPin, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

public func + (lhs: LayoutPin, rhs: CGFloat) -> LayoutPin {
    var lhs = lhs
    lhs.constant += rhs
    return lhs
}

public func - (lhs: LayoutPin, rhs: CGFloat) -> LayoutPin {
    var lhs = lhs
    lhs.constant -= rhs
    return lhs
}

public func * (lhs: LayoutPin, rhs: CGFloat) -> LayoutPin {
    var lhs = lhs
    lhs.multiplier *= rhs
    return lhs
}

public func / (lhs: LayoutPin, rhs: CGFloat) -> LayoutPin {
    var lhs = lhs
    lhs.multiplier /= rhs
    return lhs
}
