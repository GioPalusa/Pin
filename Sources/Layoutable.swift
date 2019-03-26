#if os(macOS)
    import AppKit
    public typealias View = NSView
    public typealias LayoutPriority = NSLayoutPriority
    public typealias Insets = EdgeInsets

    @available(OSX 10.11, *)
    public typealias LayoutGuide = NSLayoutGuide
#elseif os(iOS) || os(tvOS)
    import UIKit
    public typealias View = UIView
    public typealias LayoutPriority = UILayoutPriority
    public typealias Insets = UIEdgeInsets

    @available(iOS 9.0, *)
    public typealias LayoutGuide = UILayoutGuide
#endif

public protocol Layoutable: AnyObject {}

extension Layoutable {

    public var leftPin: LayoutPin {
        return LayoutPin(item: self, attribute: .left)
    }

    public var rightPin: LayoutPin {
        return LayoutPin(item: self, attribute: .right)
    }

    public var topPin: LayoutPin {
        return LayoutPin(item: self, attribute: .top)
    }

    public var bottomPin: LayoutPin {
        return LayoutPin(item: self, attribute: .bottom)
    }

    public var leadingPin: LayoutPin {
        return LayoutPin(item: self, attribute: .leading)
    }

    public var trailingPin: LayoutPin {
        return LayoutPin(item: self, attribute: .trailing)
    }

    public var widthPin: LayoutPin {
        return LayoutPin(item: self, attribute: .width)
    }

    public var heightPin: LayoutPin {
        return LayoutPin(item: self, attribute: .height)
    }

    public var centerXPin: LayoutPin {
        return LayoutPin(item: self, attribute: .centerX)
    }

    public var centerYPin: LayoutPin {
        return LayoutPin(item: self, attribute: .centerY)
    }

    public func pinEdges(to other: Layoutable, insets: Insets = Insets(top: 0, left: 0, bottom: 0, right: 0)) -> [NSLayoutConstraint] {
        return [
            leftPin == other.leftPin + insets.left,
            rightPin == other.rightPin - insets.right,

            topPin == other.topPin + insets.top,
            bottomPin == other.bottomPin - insets.bottom
        ]
    }

    public func pinCenter(to other: Layoutable, offset: CGPoint = .zero, multiplier: CGFloat = 1) -> [NSLayoutConstraint] {
        return [
            centerXPin == other.centerXPin * multiplier + offset.x,
            centerYPin == other.centerYPin * multiplier + offset.y,
        ]
    }
}

#if os(iOS) || os(tvOS)
    public extension Layoutable {
        var leftMarginPin: LayoutPin {
            return LayoutPin(item: self, attribute: .leftMargin)
        }

        var rightMarginPin: LayoutPin {
            return LayoutPin(item: self, attribute: .rightMargin)
        }

        var topMarginPin: LayoutPin {
            return LayoutPin(item: self, attribute: .topMargin)
        }

        var bottomMarginPin: LayoutPin {
            return LayoutPin(item: self, attribute: .bottomMargin)
        }

        var leadingMarginPin: LayoutPin {
            return LayoutPin(item: self, attribute: .leadingMargin)
        }

        var trailingMarginPin: LayoutPin {
            return LayoutPin(item: self, attribute: .trailingMargin)
        }

        var edgeMarginPins: [LayoutPin] {
            return [topMarginPin, leftMarginPin, bottomMarginPin, rightMarginPin]
        }

        func pinEdgeMargins(to other: Layoutable, insets: Insets = Insets(top: 0, left: 0, bottom: 0, right: 0)) -> [NSLayoutConstraint] {
            return [
                leftPin == other.leftMarginPin + insets.left,
                rightPin == other.rightMarginPin - insets.right,

                topPin == other.topMarginPin + insets.top,
                bottomPin == other.bottomMarginPin - insets.bottom
            ]
        }
    }

    public extension UILayoutSupport {
        var topPin: LayoutPin {
            return LayoutPin(item: self, attribute: .top)
        }

        var bottomPin: LayoutPin {
            return LayoutPin(item: self, attribute: .bottom)
        }
    }

#endif

@available(iOS 9.0, OSX 10.11, *)
extension LayoutGuide: Layoutable {}

extension View: Layoutable {}

public extension View {
    var baselinePin: LayoutPin {
        return LayoutPin(item: self, attribute: .lastBaseline)
    }

    @available(iOS 8.0, OSX 10.11, *)
    var firstBaselinePin: LayoutPin {
        return LayoutPin(item: self, attribute: .firstBaseline)
    }

    var lastBaselinePin: LayoutPin {
        return LayoutPin(item: self, attribute: .lastBaseline)
    }
}
