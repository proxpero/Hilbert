
public struct HilbertCurve {

    fileprivate let edge: Int
//    fileprivate var points: Array<Point> = []
    public init(edge: Int) {
        self.edge = edge
//        self.points = (0 ..< edge*edge).map(point)
    }

    fileprivate func point(with distance: Int) -> Point {

        var result = Point(x: 0, y: 0)
        var temp = distance

        let levels = sequence(first: 1) { level in
            let next = level * 2
            guard next < self.edge else { return nil }
            return next
        }

        for level in levels {
            let quadrant = Quadrant(distance: temp)
            result.rotating(in: quadrant, at: level)
            result.transforming(in: quadrant, at: level)
            temp /= 4
        }

        return result
    }

    fileprivate func distance(to point: Point) -> Int {

        var point = point
        var result = 0

        let levels = sequence(first: edge/2) { level in
            let next = level / 2
            guard next > 0 else { return nil }
            return next
        }

        for level in levels {
            let quadrant = Quadrant(point: point, level: level)
            result += quadrant.increment(with: level)
            point.rotating(in: quadrant, at: level)
        }
        
        return result
    }
    
}

extension HilbertCurve: Collection {

    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return edge * edge
    }

    public subscript(distance: Int) -> Point {
        get {
            return point(with: distance)
        }
    }

    public func index(after i: Int) -> Int {
        return i + 1
    }

}

