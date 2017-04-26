
public struct HilbertCurve {

    private let edge: Int

    public init(edge: Int) {
        self.edge = edge
    }

    public func point(with distance: Int) -> Point {

        var result = Point(x: 0, y: 0)
        var temp = distance

        let levels = sequence(first: 1) { level in
            let next = level * 2
            guard next < self.edge else { return nil }
            return next
        }

        for level in levels {
            let quadrant = Quadrant(distance: temp)
            result.flipping(in: quadrant, at: level)
            result.stretching(in: quadrant, at: level)
            temp /= 4
        }

        return result
    }

    public func distance(to point: Point) -> Int {

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
            point.flipping(in: quadrant, at: level)
        }
        
        return result
    }
    
}
