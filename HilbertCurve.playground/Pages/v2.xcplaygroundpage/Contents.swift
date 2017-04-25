
extension Int {
    init(_ value: Bool) {
        self = value ? 1 : 0
    }
}

struct HilbertCurve {

    struct Point {
        var x: Int // var so can be reassigned in point(with distance)
        var y: Int
    }

    let edge: Int

    private func rotate(n: Int, point: inout Point, rx: Int, ry: Int) {
        var x = point.x
        var y = point.y
        if ry == 0 {
            if rx == 1 {
                x = n - 1 - x
                y = n - 1 - y
            }
            point = Point(x: y, y: x)
        }
    }

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
            rotate(n: s, point: &result, rx: rx, ry: ry)
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
        var s = edge / 2
        while s > 0 {
            defer { s /= 2 }
            rx = Int((point.x & s) > 0)
            ry = Int((point.y & s) > 0)
            result += s * s * ((3 * rx) ^ ry)
            rotate(n: s, point: &point, rx: rx, ry: ry)
        }
        return result
    }

}

extension HilbertCurve.Point: CustomStringConvertible {
    var description: String {
        return "(\(x), \(y))"
    }
}

let h = HilbertCurve(edge: 8)
let d = 42
h.point(with: d)

h.distance(to: HilbertCurve.Point(x: 7, y: 7))

var points: Array<HilbertCurve.Point> = []
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

