
public struct Point {

    public let x: Int
    public let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public mutating func rotating(in quadrant: Quadrant, at level: Int) {
        if quadrant.isBottom {
            if !quadrant.isLeft {
                self = Point(
                    x: level - 1 - x,
                    y: level - 1 - y
                )
            }
            self = Point(x: y, y: x)
        }
    }

    public mutating func transforming(in quadrant: Quadrant, at level: Int) {
        self = Point(
            x: x + (quadrant.isLeft ? 0 : level),
            y: y + (quadrant.isBottom ? 0 : level)
        )
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        return "(\(x), \(y))"
    }
}
