
public struct Point {

    public var x: Int
    public var y: Int

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
}

extension Point: CustomStringConvertible {
    public var description: String {
        return "(\(x), \(y))"
    }
}
