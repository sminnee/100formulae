final int W = 800;
final int H = 600;


final int BOX_OFFSET = 25;
final int BOX_SIZE = 30;
final int BOX_SPACING = 10;

ColorBlend blender = new ColorBlend(
	{0, 200, 500, 1000 },
	{ #000000, #FF0000, #00FF00, #0000FF }
);

int w = 1+floor((W-BOX_OFFSET-BOX_SIZE) / (BOX_SPACING+BOX_SIZE));
int h = 1+floor((H-BOX_OFFSET-BOX_SIZE) / (BOX_SPACING+BOX_SIZE));
Box[][] boxes = new Box[w][h];

void setup() {

	size(W, H);
	background(0);

	int w = floor((W-BOX_OFFSET-BOX_SIZE) / (BOX_SPACING+BOX_SIZE));
	int h = floor((H-BOX_OFFSET-BOX_SIZE) / (BOX_SPACING+BOX_SIZE));
	
	for(int i=0;i<boxes.length;i++) {
		for(int j=0;j<boxes[i].length;j++) {
			int x = BOX_OFFSET + (BOX_SPACING+BOX_SIZE)*i;
			int y = BOX_OFFSET + (BOX_SPACING+BOX_SIZE)*j;
			boxes[i][j] = new Box(x,y,BOX_SIZE,BOX_SIZE);
		}
	}
	
	frameRate(40);
}

void draw() {	
	background(0);

	for(int i=0;i<boxes.length;i++) {
		for(int j=0;j<boxes[i].length;j++) {
			// Redraw
			boxes[i][j].draw();
			
			// Energise / de-energise based on mouseover
			boxes[i][j].energiseFromMouse();
		}
	}
			
	for(int i=0;i<boxes.length;i++) {
		for(int j=0;j<boxes[i].length;j++) {
			// Draw energy from direct neighbours
			if(i>0) boxes[i][j].energiseFrom(boxes[i-1][j]);
			if(i<boxes.length-1) boxes[i][j].energiseFrom(boxes[i+1][j]);
			if(j>0) boxes[i][j].energiseFrom(boxes[i][j-1]);
			if(j<boxes[i].length-1) boxes[i][j].energiseFrom(boxes[i][j+1]);
			
		}
	}
	
	// Raindrop energy
	if(random(10) <= 1) {
		int i = floor(random(boxes.length));
		int j = floor(random(boxes[i].length));
		boxes[i][j].energise();
	}
}

class Box {
	int x,y,w,h;
	int energy;
	Box(int xVal, int yVal, int wVal, int hVal) {
		x = xVal;
		y = yVal;
		w = wVal;
		h = hVal;
		
		energy = 1000;
	}
	
	void draw() {
		fill(0);
		strokeWeight(energy/125);
		stroke(blender.forLevel(energy));

		rect(x,y,w,h);
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