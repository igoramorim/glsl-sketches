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
    
    // pct.r = abs(sin(cos(st.y + u_time) * 10. * st.x + u_time));

    float r = length(pos)*abs(sin(u_time+st.x)*abs(cos(u_time+st.y)))*10.;
    r *= abs(cos(a*4.));

    f = cos(a*u_time*3.);
    // f *= cos(a*abs(sin(u_time*PI)))+1.;

    color = vec3( 1.-smoothstep(f,f+0.02,r) );

    gl_FragColor = vec4(color, 1.0);
}
