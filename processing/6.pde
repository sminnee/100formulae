final int W = 800;
final int H = 600;


ColorBlend blender = new ColorBlend(
	{0, 333, 666, 1000 },
	{ #000000, #FF0000, #00FF00, #FF0000 }
);

Shape[] b;
int t=0;
int currentPattern = -1;

void setup() {
	size(W, H);
	background(0);
	
	frameRate(2.33);
}
	

void draw() {
	nextShapeSet( (t%4 == 0) );
	t++;

	background(0);
	
	for(int i=0;i<b.length;i++) {
//		b[i].energiseFromMouse();
		b[i].draw();
	}
}

void nextShapeSet(changePattern) {
	if(changePattern) {
		currentPattern = (currentPattern+1)%4;
	}
	
	int numX, numY;
	switch(currentPattern) {
	case 0:
		numX = 4;
		numY = 3;
		break;

	case 1:
		numX = 8;
		numY = 6;
		break;

	case 2:
		numX = 16;
		numY = 12;
		break;

	case 3:
		numX = 32;
		numY = 24;
		break;
	}

	// Half of line width
	int buffer = 10;

	// Some calculations
	// shape size = (4*gap)-buffer
	// (num+1)*gap + (num * ((4*gap)-buffer)) = W
	// num*gap + gap + 4*num*gap - buffer*num = W
	// 5*num*gap + gap - buffer*num = W
	// (5*num+1)*gap = W + buffer*num
	// gap = (W+buffer*num)/(5*num+1) 
	
	int gapX = (W + buffer*numX) / (5*numX + 1);
	int gapY = (H + buffer*numY) / (5*numY + 1);

	int sizeX = gapX*4-buffer;
	int sizeY = gapY*4-buffer;
	
	buildShapes(
		numX, numY,  
		sizeX, sizeY,
		gapX, gapY,
		gapX+sizeX, gapY+sizeY
	);
}

void buildShapes(numX, numY, w, h, startX, startY, gapX, gapY) {
	b = new Shape[numX*numY];

	for(int i=0; i<numX; i++) {
		for(int j=0; j<numY; j++) {
			b[j+i*numY] = new Shape(startX+i*gapX,startY+j*gapY,w,h);
		}
	}
}


class Shape {
	int x,y,w,h;
	int energy;
	int roundiness;
	int shape; // 0 = circle, 1 = square, 2 = triangle, 3 = diamond
	int color;
	
	Shape(int xVal, int yVal, int wVal, int hVal) {
		x = xVal;
		y = yVal;
		w = wVal;
		h = hVal;
		
		energy = 1000;
		roundiness = 0;

		shape = floor(random(0,4));
		switch(floor(random(0,3))) {
		case 0:
			color = #FF0000;
			break;
		
		case 1:
			color = #00FF00;
			break;
		
		case 2:
			color = #0000FF;
			break;
		}
	}
		
	void draw() {
		fill(0);

		roundiness = sin(energy/30);

		strokeWeight(1);
//		stroke(blender.forLevel(energy));
		stroke(color);
		fill(color);
		
		int size = roundiness * w/2 * energy/1000;
		
		size = 0;
		
		switch(shape) {
		case 0:
			ellipse(x+w/2,y+h/2,w,h);
			break;
			
		case 1:
			rect(x,y,w,h);
			break;
			
		case 2:
			triangle(x,y+h, x+w,y+h, x+w/2,y);
			break;
			
		case 3:
			quad(x,y+h/2, x+w/2,y+h, x+w,y+h/2, x+w/2,y);
			break;
			
		}

		
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