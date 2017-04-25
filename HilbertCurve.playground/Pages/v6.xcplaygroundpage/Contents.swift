
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

