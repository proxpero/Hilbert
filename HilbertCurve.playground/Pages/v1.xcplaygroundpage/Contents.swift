
extension Int {
    init(_ value: Bool) {
        self = value ? 1 : 0
    }
}

func xy2d(_ n: Int, _ x: Int, _ y: Int) -> Int {
    var xx = x
    var yy = y
    var rx = 0
    var ry = 0
    var s = n / 2
    var d = 0
    while s > 0 {
        defer { s /= 2 }
        rx = Int((xx & s) > 0)
        ry = Int((yy & s) > 0)
        d += s * s * ((3 * rx) ^ ry)
        rot(s, &xx, &yy, rx, ry)
    }
    return d
}

func d2xy(_ n: Int, _ d: Int, _ x: inout Int, _ y: inout Int) {
    var rx = 0
    var ry = 0
    var s = 1
    var t = d
    x = 0
    y = 0
    while s < n {
        defer { s *= 2 }
        rx = 1 & (t / 2)
        ry = 1 & (t ^ rx)
        rot(s, &x, &y, rx, ry)
        x += s * rx
        y += s * ry
        t /= 4
    }
}

func rot(_ n: Int, _ x: inout Int, _ y: inout Int, _ rx: Int, _ ry: Int) {
    if (ry == 0) {
        if (rx == 1) {
            x = n - 1 - x
            y = n - 1 - y
        }
        let t = x
        x = y
        y = t
    }
}

let n = 8



let d = 42
var x = 0
var y = 0
d2xy(n, d, &x, &y)
xy2d(n, 7, 7)

var points: Array<(Int, Int)> = []
for e in 0...3 {
    var x = 0
    var y = 0
    d2xy(2, e, &x, &y)
    print("(\(x), \(y))")
    points.append((x, y))
}

for p in points {
    let d = xy2d(2, p.0, p.1)
    print("\(d)")
}
