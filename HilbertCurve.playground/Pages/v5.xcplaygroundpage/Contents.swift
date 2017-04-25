
extension Int {
    init(_ value: Bool) {
        self = value ? 1 : 0
    }
}

struct HilbertCurve {

    let edge: Int

    func point(with distance: Int) -> Point {

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

    func distance(to point: Point) -> Int {

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

var points: Array<Point> = []
let test = HilbertCurve(edge: 4)
for e in 0...15 {
    let p = test.point(with: e)
    print(p)
    points.append(p)
}

for p in points {
    let d = test.distance(to: p)
    print("\(d)")
}
