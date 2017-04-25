
extension Int {
    init(_ value: Bool) {
        self = value ? 1 : 0
    }
}

struct HilbertCurve {

    let edge: Int

    func point(with distance: Int) -> Point {
        var result = Point(x: 0, y: 0)
        var rx = 0
        var ry = 0
        var t = distance
        var s = 1
        while s < edge {
            defer { s *= 2 }
            rx = 1 & (t / 2)
            ry = 1 & (t ^ rx)
            result.rotating(rx: rx, ry: ry, at: s)
            result.x += s * rx
            result.y += s * ry
            t /= 4
        }
        return result
    }

    func distance(to point: Point) -> Int {
        var point = point
        var rx = 0
        var ry = 0
        var result = 0
        var level = edge / 2
        while level > 0 {
            defer { level /= 2 }
            rx = Int((point.x & level) > 0)
            ry = Int((point.y & level) > 0)
            result += level * level * ((3 * rx) ^ ry)
            point.rotating(rx: rx, ry: ry, at: level)
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


