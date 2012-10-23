final int W = 800;
final int H = 600;

Agent a;

void setup() {
	size(W, H);
	background(0);
	
	a = new Agent(30,570,0);
	a.life = (int)random(150,250);
	a.sizeDecay = 0.03;
	
	frameRate(1000);
	
}

void draw() {
	a.move();
	a.meanderTowardsByAngle(800,0,0.2,PI/10);
	a.draw();

	if(a.isDead()) {
		a.life = (int)random(150,250);
		a.size = 10;
		a.speed = 5;
		a.x = 30;
		a.y = 570;
	}
}

// A vehicle that moves around by angle
class Agent {
	int x,y;
	float speed;
	float angle;
	float size;
	float sizeDecay;
	int life;
	
	Agent(int xVal, int yVal, int angleVal) {
		x = xVal;
		y = yVal;
		angle = angleVal;
		size = 10;
		speed = size/2;
		life = -1;
	}
	
	void move() {
		x += cos(angle)*speed;
		y += sin(angle)*speed;
		
		if(sizeDecay > 0) {
			size -= sizeDecay;
			speed = size/2;
		}
		
		if(life > 0) {
			life--;
		}
	}
	
	boolean isDead() {
		return (life == 0);
	}

	void draw() {
		stroke(#FFFFFF);
		fill(#000000);
		ellipse(x,y,size,size);
	}
	
	void turnTowards(int destX, int destY, float turnAmount) {
		float destAngle = getDestAngleTo(destX, destY);
	
		// Choose the right direction to turn
		if(angle < destAngle) angle += turnAmount;
		else angle -= turnAmount;
	}
	
	// Turn generally towards a place, meandering randomly the closer one gets
	// meanderFactor is the distance at which the chosen direction becomes random
	void meanderTowards(int destX, int destY, float turnAmount, int meanderFactor) {
		float destAngle = getDestAngleTo(destX, destY);

		if(random(max(meanderFactor,distanceTo(destX,destY))) < meanderFactor/2) {
			turnAmount *= -1;
		}

		// Choose the right direction to turn
		if(angle < destAngle) angle += turnAmount;
		else angle -= turnAmount;
	}

	// Turn generally towards a place, meandering randomly the closer one gets
	// meanderFactor is the angular distance at which the chosen direction becomes random
	void meanderTowardsByAngle(int destX, int destY, float turnAmount, float meanderFactor) {
		float destAngle = getDestAngleTo(destX, destY);
		
		if(random(max(meanderFactor, abs(angle - destAngle))) < meanderFactor/2) {
			turnAmount *= -1;
		}

		// Choose the right direction to turn
		if(angle < destAngle) angle += turnAmount;
		else angle -= turnAmount;
	}
	
	float distanceTo(int destX, int destY) {
		int diffX = destX-x;
		int diffY = destY-y;
		return sqrt(diffX*diffX + diffY*diffY);
	}
	
	float getDestAngleTo(int destX, int destY) {
		int diffX = destX-x;
		int diffY = destY-y;
	
		int size = (destX*destX+destY*destY)/2000;

		float destAngle;
	 	destAngle = atan2(diffY,diffX);

		// Align the current angle and the dest angle so that < & > comparison works
		while(abs(angle-destAngle) > abs(angle-(destAngle+2*PI)) ) {
			destAngle += 2*PI;
		}
		while(abs(angle-destAngle) > abs(angle-(destAngle-2*PI)) ) {
			destAngle -= 2*PI;
		}

		return destAngle;
	}


	
}