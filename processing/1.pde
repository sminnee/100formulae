void setup() {
	final int W = 800;
	final int H = 600;
	final int NUM_POINTS = 1000;

	size(W, H);
	background(0);

	int[] xCentre = new int[NUM_POINTS];
	int[] yCentre = new int[NUM_POINTS];

	int i;
	for(i=0;i<NUM_POINTS;i++) {
		xCentre[i] = (int)random(W);
		yCentre[i] = (int)random(H);
	}


	int x,y, level;
	int dX,dY,distSquared,minDistSquared;
	int maxDistSquared = W*W+H*H;
	int closest;

	float totalEnergy;

	final int CLOUD_SIZE = 60;

	for(x=0;x<W;x++) {
		for(y=0;y<H;y++){
			//minDistSquared = maxDistSquared;
			totalEnergy = 0;
			for(i=0;i<NUM_POINTS;i++) {
				dX = x - xCentre[i];
				dY = y - yCentre[i];

				distSquared = dX*dX + dY*dY;
				totalEnergy += CLOUD_SIZE*CLOUD_SIZE/distSquared;

				//if(distSquared < minDistSquared) {
				//	minDistSquared = distSquared;
				//	closest = i;
				//}
			}

			if(totalEnergy > 0) {
				level = min(255, totalEnergy*totalEnergy/500);
				stroke(level);
				point(x,y);
			}

		}
	}

//	stroke(#FF0000);
//	for(i=0;i<NUM_POINTS;i++) {
//		point(xCentre[i],yCentre[i]);
//	}


}