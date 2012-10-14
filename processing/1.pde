void setup() {
	final int W = 800;
	final int H = 600;
	final int NUM_POINTS = 2000;
	final int CLOUD_SIZE = 30;

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
	int dX,dY,distSquared;
	int closest;

	float totalEnergy;


	for(x=0;x<W;x++) {
		for(y=0;y<H;y++){
			totalEnergy = 1;
			for(i=0;i<NUM_POINTS;i++) {
				dX = x - xCentre[i];
				dY = y - yCentre[i];

				distSquared = dX*dX + dY*dY;
				totalEnergy *= max(1,CLOUD_SIZE*CLOUD_SIZE/distSquared);
			}

			if(totalEnergy > 0) {
				if(totalEnergy > 2000000) level = 255;
				else if(totalEnergy > 200000) level = (totalEnergy-200000)/1800000*255;
				else level = 0;

				stroke(level);
				point(x,y);
			}

		}
	}
}