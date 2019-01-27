#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.14159265359

// Plot a line on Y using a value between 0.0-1.0
float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;

    float s = abs(sin(u_time));

    // float y = 1. - pow(abs(st.x), 0.5);
    // float y = 1. - pow(abs(st.x), 1.);
    // float y = 1. - pow(abs(st.x), 1.5);    
    // float y = 1. - pow(abs(st.x), s * 3.);
    
    // float y = pow(cos(PI * st.x / 2.), .5);
    // float y = pow(cos(PI * st.x / 2.), 1.);
    // float y = pow(cos(PI * st.x / 2.), 2.);
    // float y = pow(cos(PI * st.x / 2.), 2.5);
    // float y = pow(cos(PI * st.x / 2.), 3.5);
    // float y = pow(cos(PI * st.x / 2.), s * 4.);
    
    // float y = 1. - pow(abs(sin(PI * st.x / 2.)), .5);
    // float y = 1. - pow(abs(sin(PI * st.x / 2.)), 1.);
    // float y = 1. - pow(abs(sin(PI * st.x / 2.)), 1.5);
    // float y = 1. - pow(abs(sin(PI * st.x / 2.)), 2.);
    // float y = 1. - pow(abs(sin(PI * st.x / 2.)), s * 3.);
    
    // float y = pow(min(cos(PI * st.x / 2.), 1. - abs(st.x)), .5);
    // float y = pow(min(cos(PI * st.x / 2.), 1. - abs(st.x)), 1.);
    // float y = pow(min(cos(PI * st.x / 2.), 1. - abs(st.x)), 1.5);
    // float y = pow(min(cos(PI * st.x / 2.), 1. - abs(st.x)), 2.);
    // float y = pow(min(cos(PI * st.x / 2.), 1. - abs(st.x)), 3.);
    // float y = pow(min(cos(PI * st.x / 2.), 1. - abs(st.x)), s * 3.);
    
    // float y = 1. - pow(max(0., abs(st.x) * 2. - 1.), .5);
    // float y = 1. - pow(max(0., abs(st.x) * 2. - 1.), 1.);
    // float y = 1. - pow(max(0., abs(st.x) * 2. - 1.), 1.5);
    // float y = 1. - pow(max(0., abs(st.x) * 2. - 1.), 2.);
    // float y = 1. - pow(max(0., abs(st.x) * 2. - 1.), 2.5);
    float y = 1. - pow(max(0., abs(st.x) * 2. - 1.), s * 3.);

    vec3 color = vec3(y);

    // Plot a line
    float pct = plot(st,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}