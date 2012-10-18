final int W = 800;
final int H = 600;


ColorBlend blender = new ColorBlend(
	{0, 333, 666, 1000 },
	{ #000000, #FF0000, #00FF00, #FF0000 }
);

Box[] b = new Box[6];
int t=0;

void setup() {

	size(W, H);
	background(0);
	
	b[0] = new Box(75,75,150,150);
	b[1] = new Box(325,75,150,150);
	b[2] = new Box(575,75,150,150);
	b[3] = new Box(75,375,150,150);
	b[4] = new Box(325,375,150,150);
	b[5] = new Box(575,375,150,150);
	
	frameRate(40);
}

void draw() {
	t++;

	background(0);
	
	for(int i=0;i<b.length;i++) {
		b[i].energiseFromMouse();
		b[i].draw();
	}

}

class Box {
	int x,y,w,h;
	int energy;
	int roundiness;
	
	Box(int xVal, int yVal, int wVal, int hVal) {
		x = xVal;
		y = yVal;
		w = wVal;
		h = hVal;
		
		energy = 1000;
		roundiness = 0;
	}
	
	void draw() {
		fill(0);

		roundiness = sin(energy/30);

		strokeWeight(energy/125);
		stroke(blender.forLevel(energy));
		
		int size = roundiness * w/2 * energy/1000;
		int corners = roundiness * w/2 * energy/1000;

		rect(x-size,y-size,w+2*size,h+2*size, corners);
	}
	
	void energiseFromMouse() {
		if(isMouseOver()) energy = 1000;
		else energy = max(energy-10,0);
	}

	void energise() {
		energy = 1000;
	}

	void energiseFrom(Box other) {
		if(other.energy > energy) {
			energy += (other.energy-energy) * 0.15;
		}
		if(isMouseOver()) energy = 1000;
		else energy = max(energy-10,0);
	}
	
	boolean isMouseOver() {
		return mouseX >= x && mouseX <= (x+w) && mouseY >= y && mouseY <= (y+h);
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