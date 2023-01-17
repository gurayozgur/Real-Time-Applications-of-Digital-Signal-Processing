#include <ansi_c.h>
#include <stdio.h>

void rgb2gray(int* src, int total){
	
	int r, g, b;
	for (int i = 0; i<total; i++){
        b = *(src + i) & 0xFF; // load red
        g = *(src + i)>>8 & 0xFF; // load green
        r = *(src + i)>>16 & 0xFF; // load blue
        // build weighted average:
        *(src + i) = (unsigned char)(r * 0.299+ g * 0.587 + b * 0.114);
	}
}

void gray2rgb(int* src, int total, float* colormap){
	unsigned char r,g,b;
	
	for(int i = 0; i<total; i++){
	r = *(colormap + 3*src[i]) * src[i];
	g = *(colormap + 3*src[i] + 1) * src[i];
	b = *(colormap + 3*src[i] + 2) * src[i];
	*(src + i) = (r<<16) + (g<<8) + b;
		
	}
	
}