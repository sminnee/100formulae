final int W = 800;
final int H = 600;

void setup() {

	size(W, H);
	background(0);

	frameRate(140);
}

int t=0;
float a1=0;
float a2=0;
int r=5;

void draw() {
	float sigmoidIn = (t-30)/5;
	float sigmoidOut = 1/(1+pow(2.71828182846, -sigmoidIn));

	a2 = a1 + sigmoidOut * PI/2;
	
	int frameR = r + r * sin(t/60*PI);
	
	stroke(#FF0000);
	fill(#770000);

	background(0);
	
	int red = 255;
	for(a=a2;a>a1;a-=0.02) {
		stroke(color(red,0,0));
		fill(color(red/2,0,0));
		arc(400,300,frameR,frameR, max(a1, a-0.02), a);
		red -= 2;
	}


	t = (t+1) % 60;
	if(t==0) {
		a1 += PI/2;
		r += 5;
	}
}