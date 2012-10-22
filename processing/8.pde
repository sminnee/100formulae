final int W = 800;
final int H = 600;

int x1=0, x2=0, x3=0, y1=0, y2=0, y3=0;

void setup() {

	size(W, H);
	background(0);
	
	x1 = random(W);
	y1 = random(H);
	bubbleStep();

	frameRate(1000);
}

void bubbleStep() {
	x3 = x2;
	y3 = y2;
	x2 = x1;
	y2 = y1;
	
	int dX,dY;
	
	if(x1 < W/2) dX = random(0,50);
	else dX = random(-50,0);

	if(y1 < H/2) dY = random(0,50);
	else dY = random(-50,0);
	
	dist = sqrt((x1-W/2)*(x1-W/2)+(y1-H/2)*(y1-H/2));
	
	if(max(200,dist) < random(400)) dX *= -1;
	if(max(200,dist) < random(400)) dY *= -1;
	
	x1 += dX;
	y1 += dY;
	
}

void draw() {
	bubbleStep();
	
	stroke(#FFFFFF);
	fill(#000000);
	triangle(x1,y1,x2,y2,x3,y3);
}