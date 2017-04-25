
public struct Point {

    public let x: Int
    public let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public mutating func rotating(rx: Int, ry: Int, at level: Int) {
        if ry == 0 {
            var x = self.x
            var y = self.y
            if rx == 1 {
                x = level - 1 - x
                y = level - 1 - y
            }
            self = Point(x: y, y: x)
        }
    }

    public mutating func transforming(rx: Int, ry: Int, at level: Int) {
        self = Point(
            x: x + (level * rx),
            y: y + (level * ry)
        )
    }

    // Reflection in y = x:  (x, y) --> (y, x)
    mutating func reflectingInXY() {
        self = Point(x: y, y: x)
    }

    public mutating func rotating(in quadrant: Quadrant, at level: Int) {

        if quadrant.isBottom {
//            var x = self.x
//            var y = self.y
            if !quadrant.isLeft {
                self = Point(
                    x: level - 1 - x,
                    y: level - 1 - y
                )
            }
//            self = Point(x: x, y: y)
            self.reflectingInXY()
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
