void setup() {
	final int W = 800;
	final int H = 600;

	size(W, H);
	background(0);
	
	stroke(#FF0000);
	fill(#000000);
	
	int i, x = 30;
	for(i=0;i<20;i++) {
		stroke(#FF0000);
		rot_rect(x,100, (20-i) * 2,150, i*5);

		stroke(#00FF00);
		rot_rect(x,300, (20-i) * 2 + random(-30,30),100, i*5);

		stroke(#0000FF);
			rot_rect(x,500+random(-50,50), (20-i) * 2,50, i*5);

		x += (i+3)*5+(10-i)*2;
	}
}

void rot_rect(x,y,w,h,a) {
	pushMatrix();

	translate(x,y);
	rotate(a*PI/180);
	
	rect(-w/2,-h/2, w,h);
	
	popMatrix();
}