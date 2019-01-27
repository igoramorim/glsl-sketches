// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float bounceOut(float t) {
  const float a = 4.0 / 11.0;
  const float b = 8.0 / 11.0;
  const float c = 9.0 / 10.0;

  const float ca = 4356.0 / 361.0;
  const float cb = 35442.0 / 1805.0;
  const float cc = 16061.0 / 1805.0;

  float t2 = t * t;

  return t < a
    ? 7.5625 * t2
    : t < b
      ? 9.075 * t2 - 9.9 * t + 3.4
      : t < c
        ? ca * t2 - cb * t + cc
        : 10.8 * t * t - 20.52 * t + 10.72;
}

float bounceIn(float t) {
  return 1.0 - bounceOut(1.0 - t);
}

float bounceInOut(float t) {
  return t < 0.5
    ? 0.5 * (1.0 - bounceOut(1.0 - t * 2.0))
    : 0.5 * bounceOut(t * 2.0 - 1.0) + 0.5;
}

float myCircle(vec2 st, vec2 pos, float r) {
    float pct = 0.0;
    pct = distance(st, pos);
    pct = step(r, pct);
    return pct;
}

void main(){
	vec2 st = gl_FragCoord.xy/u_resolution;
    float pct = 0.0;

    // a. The DISTANCE from the pixel to the center
    // pct = distance(st,vec2(0.5));

    // b. The LENGTH of the vector
    //    from the pixel to the center
    // vec2 toCenter = vec2(0.5)-st;
    // pct = length(toCenter);

    // c. The SQUARE ROOT of the vector
    //    from the pixel to the center
    // vec2 tC = vec2(0.5)-st;
    // pct = sqrt(tC.x*tC.x+tC.y*tC.y);

    // defined circle
    // pct = step(0.5, pct);
    // invert colors
    // pct = 1. - pct;
    // different gradient sizes 
    // pct = smoothstep(0.1, 0.9, pct);

    float s1 = bounceIn( abs(sin(u_time)) );
    pct = myCircle(st, vec2(.5, .5), 0.01);
    pct *= myCircle(st, vec2(abs(cos(u_time)), abs(sin(u_time))), s1*.2);
    pct *= myCircle(st, vec2(0.5 + abs(cos(u_time) -.5), 0.5), 0.1);
    
    vec3 color = vec3(pct);

	gl_FragColor = vec4( color, 1.0 );
}
