
#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random(float p) {
    return fract(sin(p)*10000.);
}

float getColorComponent(float dist, float angle, float scaleIncrement) {
    return sin(dist * (60.0 + scaleIncrement) + angle - (u_time * 1.0));
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);
	float f = 0.0;
    
    vec2 pos = vec2(0.5)-st;
    float a = atan(pos.y,pos.x);
    float r = length(pos)*10.;
    
    // f = cos(a*3.);
    // f = cos(a*abs(sin(u_time*PI)))+1.;
    // f = 2.5;
    // f = .2*a;
    // f = 2.*a;
    // f = cos(a*u_time);
    f = cos(a*abs(sin(u_time*.3))*5.+random(pos.x))+sin(u_time+r+a)+PI;
    // f *= 1.+abs(sin(u_time*.5)-cos(u_time*.5));
    f *= sin(u_time*random(pos.y));
    
    // f = abs(cos(a*3.));
    // f = abs(cos(a*2.5))*.5+.3;
    // f = abs(cos(a*12.)*sin(a*3.))*.8+.1;
    // f = smoothstep(-.5,1., cos(a*10.))*0.2+0.5;
    
    color = vec3( 1.-smoothstep(f,f+0.02,r) );
    color.r *= getColorComponent(r, a, 0.0);
    color.g *= getColorComponent(r, a, 1.0);
    color.b *= getColorComponent(r, a, 2.0);

    gl_FragColor = vec4(color, 1.0);
}
