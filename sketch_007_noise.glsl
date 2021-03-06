// Code based from http://pixelshaders.com/

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random(float p) {
    return fract(sin(p)*10000.);
}

float noise(vec2 p) {
    return random(p.x + p.y * 10000.);
}

float stepNoise(vec2 p) {
    return noise(floor(p));
}

vec2 sw(vec2 p) {return vec2( floor(p.x) , floor(p.y) );}
vec2 se(vec2 p) {return vec2( ceil(p.x)  , floor(p.y) );}
vec2 nw(vec2 p) {return vec2( floor(p.x) , ceil(p.y)  );}
vec2 ne(vec2 p) {return vec2( ceil(p.x)  , ceil(p.y)  );}

float smoothNoise(vec2 p) {
    vec2 inter = smoothstep(0., 1., fract(p));
  	float s = mix(noise(sw(p)), noise(se(p)), inter.x);
  	float n = mix(noise(nw(p)), noise(ne(p)), inter.x);
  	return mix(s, n, inter.y);
  	return noise(nw(p));
}

float movingNoise(vec2 p) {
  	float total = 0.0;
  	total += smoothNoise(p     - u_time);
  	total += smoothNoise(p*2.  + u_time) / 2.;
  	total += smoothNoise(p*4.  - u_time) / 4.;
  	total += smoothNoise(p*8.  + u_time) / 8.;
  	total += smoothNoise(p*16. - u_time) / 16.;
  	total /= 1. + 1./2. + 1./4. + 1./8. + 1./16.;
  	return total;
}

float nestedNoise(vec2 p) {
  	float x = movingNoise(p);
  	float y = movingNoise(p + 100.);
  	return movingNoise(p + vec2(x, y));
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
	st = st * 6.;
    
    float b = nestedNoise(st); // stepNoise
	gl_FragColor.rgb = vec3(b);
    gl_FragColor.a = 1.;
}