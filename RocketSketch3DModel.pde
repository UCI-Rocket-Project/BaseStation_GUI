
void drawRocket_Static(){

beginShape();
vertex(100, 100, 100);
vertex( -100, 100, 100);
vertex(   0,    0,  -100);

vertex( -100, 100, 100);
vertex( -100,  -100, 100);
vertex(   0,    0,  -100);

vertex( -100, -100, 100);
vertex(100, -100, 100);
vertex(   0,   0,  -100);

vertex(100,  -100, 100);
vertex(100, 100, 100);
vertex( 0,    0,  -100);
//pyramid tip done, make the body

vertex(100, 100, 100);
vertex(100, 100, 400);

vertex(-100, 100, 400);
vertex(-100, 100, 100);
vertex(-100, 100, 400);

vertex(-100, -100, 400);
vertex(-100, -100, 100);
vertex(-100, -100, 400);

vertex(100, -100, 400);
vertex(100, -100, 100);
vertex(100, -100, 400);

vertex(100, 100, 400);

//make the wing1
vertex(100, 0, 400);
vertex(250, 0, 400);
vertex(100, 0, 100);

//move to other side for wing2
vertex(100, -100, 100);
vertex(-100, -100, 100);

//begin drawing wing2
vertex(-100, 0, 100);
vertex(-250, 0, 400);
vertex(-100, 0, 400);

endShape(); 

}
