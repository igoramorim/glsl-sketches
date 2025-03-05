#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);
	float f = 0.0;
    
    vec2 pos = vec2(0.5)-st;
    float a = atan(pos.y,pos.x);
    float r = length(pos)*10.;
    
    f = 3.+cos(a*abs(sin(u_time*.2))*5.)*sin(u_time+a);
    f += cos(r*abs(sin(u_time*.1))*10.)*cos(u_time+a);
    f += mod(f, .3);
    
    color.r = 1.-smoothstep(f,f+0.0,r);
    color.g = 1.-smoothstep(f,f+abs(cos(a)),r);
    color.b = 1.-smoothstep(f,f+abs(sin(a)),r);

    gl_FragColor = vec4(color, 1.0);
}
