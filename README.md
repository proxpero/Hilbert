# Hilbert

A translation into Swift of an algorithm originally written in C to generate an approximation of a Hilbert space-filling curve. 

### Version 0: The original C

I took this code straight from [wikipedia](https://en.wikipedia.org/wiki/Hilbert_curve).

```C
//convert (x,y) to d
int xy2d (int n, int x, int y) {
    int rx, ry, s, d=0;
    for (s=n/2; s>0; s/=2) {
        rx = (x & s) > 0;
        ry = (y & s) > 0;
        d += s * s * ((3 * rx) ^ ry);
        rot(s, &x, &y, rx, ry);
    }
    return d;
}

//convert d to (x,y)
void d2xy(int n, int d, int *x, int *y) {
    int rx, ry, s, t=d;
    *x = *y = 0;
    for (s=1; s<n; s*=2) {
        rx = 1 & (t/2);
        ry = 1 & (t ^ rx);
        rot(s, x, y, rx, ry);
        *x += s * rx;
        *y += s * ry;
        t /= 4;
    }
}

//rotate/flip a quadrant appropriately
void rot(int n, int *x, int *y, int rx, int ry) {
    if (ry == 0) {
        if (rx == 1) {
            *x = n-1 - *x;
            *y = n-1 - *y;
        }

        //Swap x and y
        int t  = *x;
        *x = *y;
        *y = t;
    }
}
```

### Version 9: A more Swifty version.

```Swift

public struct HilbertCurve {

    fileprivate let edge: Int
    fileprivate var points: Array<Point> = []
    
    public init(edge: Int) {
        self.edge = edge
        self.points = (0 ..< edge*edge).map(point)
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
            result.flipping(in: quadrant, at: level)
            result.stretching(in: quadrant, at: level)
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
            point.flipping(in: quadrant, at: level)
        }
        
        return result
    }
    
}

extension HilbertCurve: Collection, BidirectionalCollection, RandomAccessCollection {

    public var startIndex: Int {
        return points.startIndex
    }

    public var endIndex: Int {
        return points.endIndex
    }

    public subscript(distance: Int) -> Point {
        get {
            return points[distance]
        }
    }

    public func index(after i: Int) -> Int {
        return points.index(after: i)
    }

    public var last: Point? {
        return points.last
    }

    public func index(before i: Int) -> Int {
        return points.index(before: i)
    }

    public var indices: CountableRange<Int> {
        return points.indices
    }
}
```
