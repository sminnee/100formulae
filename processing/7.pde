final int W = 800;
final int H = 600;

int x = random(W);
int y = random(H);
int angle = random(-PI, PI);

void setup() {

	size(W, H);
	background(0);
	
	frameRate(1000);
}

void draw() {
	x += cos(angle)*5;
	y += sin(angle)*5;
	
	int destX = W/2-x;
	int destY = H/2-y;
	
	int size = (destX*destX+destY*destY)/2000;

	stroke(#FFFFFF);
	fill(#000000);
	ellipse(x,y,size,size);

	float destAngle;
 	destAngle = atan2(destY,destX);

	// Align the current angle and the dest angle so that < & > comparison works
	while(abs(angle-destAngle) > abs(angle-(destAngle+2*PI)) ) {
		destAngle += 2*PI;
	}
	while(abs(angle-destAngle) > abs(angle-(destAngle-2*PI)) ) {
		destAngle -= 2*PI;
	}

	float direction;

	// Choose the right direction (boring)
	if(angle < destAngle) direction = 0.2
	else direction = -0.2;

	// Randomly choose the wrong direction
	// The further physically away, the more likely to turn in the right direction
	
	if(random(max(200,abs(destX) + abs(destY))) < 100) {
		direction *= -1;
	}
	
	angle += direction;
	
}