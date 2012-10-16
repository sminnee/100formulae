final int W = 800;
final int H = 600;

final int NUM_POINTS = 5000;
final int CONNS_PER_POINT = 5;

Point[] points = new Point[NUM_POINTS];

	ColorBlend blender = new ColorBlend(
		{0, 200, 500, 1000 },
		{ #000000, #FF0000, #FFFF00, #FFFFFF }
	);

void setup() {

	size(W, H);
	background(0);
	
	for(int i=0;i<points.length;i++) {
		points[i] = new Point(random(W), random(H));
	}
	
	frameRate(8);
}

void draw() {	
	background(0);

	for(int i=0;i<points.length/10;i++) {
		for(int j=0;j<CONNS_PER_POINT;j++) {
			int k = floor(random(points.length));
			if(k != i) {
				int dist = points[i].squareDistToPoint(points[k]);
				if(dist < 250*250) {
					int power = 2000000 / (dist+1);
					
					color c = blender.forLevel(power);
					
					stroke(c);
					strokeWeight( min(10, (power/200)+1) );
					points[i].lineToPoint(points[k]);
				}
			}
		}
	}
}

class Point {
	int x,y;
	Point(int xVal, int yVal) {
		x = xVal;
		y = yVal;
	}
	
	// Draw a line to another point
	void lineToPoint(Point p) {
		line(x,y,p.x,p.y);
	}
	
	float squareDistToPoint(Point p) {
		int dX = p.x-x;
		int dY = p.y-y;
		return dX*dX + dY*dY;
	}
	float distToPoint(Point p) {
		return sqrt(squareDistToPoint(p))
	}
}

// Used to blend between a sequence of colours 
class ColorBlend {
	int[] levels;
	color[] colors;
	
	ColorBlend(int[] levelVals, color[] colorVals ) {
		levels = levelVals;
		colors = colorVals;
	}
	
	color forLevel(int level) {
		if(level <= levels[0]) return colors[0];
		if(level > levels[levels.length-1]) return colors[levels.length-1];
		
		for(int i=1;i<levels.length;i++) {
			if(levels[i-1] <= level && levels[i] >= level) {
				float blendRate = (level-levels[i-1]) / (levels[i]-levels[i-1]);
				return blend(colors[i-1], colors[i], blendRate);
			}
		}
	}
	
	color blend(color c1, color c2, float blendRate) {
		int r1 = (int)red(c1); int r2 = (int)red(c2);
		int g1 = (int)green(c1); int g2 = (int)green(c2);
		int b1 = (int)blue(c1); int b2 = (int)blue(c2);
		
		return color(
			r1 + (r2-r1)*blendRate,
			g1 + (g2-g1)*blendRate,
			b1 + (b2-b1)*blendRate
		);
	}
}