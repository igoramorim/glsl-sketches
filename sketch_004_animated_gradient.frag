#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec3 pct = vec3(st.x);
    
    float s = abs(sin(u_time));

    // pct.r = smoothstep(0.0,1.0, st.x);
    // pct.g = sin(st.x*PI);
    // pct.b = pow(st.x,0.5 + sin(u_time) * cos(u_time));
    
    // pct.r = 1. - pow(abs(st.x), s);
    // pct.r = pow(cos(PI * st.x / 2.), s);
    // pct.r = pow(min(cos(PI * st.x / 2.), 1. - abs(st.x)), s);
    // pct.r = fract(st.x - u_time);
    // pct.r = abs(sin(cos(u_time + 3. * st.y) * 2. * st.x + u_time));
    pct.r = abs(sin(cos(st.y + u_time) * 10. * st.x + u_time));
    
    // pct.g = abs(sin((st.x * cos(u_time) * 3.) + u_time));
    pct.g = abs(cos(sin(u_time + 2. * st.x) * 5. * st.y + u_time));
    
    // pct.b = fract(st.x + u_time);
    // pct.b = ceil(st.x);
	// pct.b = .5 - ceil(st.x) + fract(st.x + u_time);
    // pct.b = -.5 + ceil(st.x) + mod(st.x, abs(sin(u_time)));
    // pct.b = clamp(st.x, abs(sin(u_time)), abs(cos(u_time)));
    // pct.b = clamp(st.x, abs(sin(u_time)), fract(st.x + sin(u_time)));
    // pct.b = abs(sin(cos(st.y * 10. + u_time) * sin(st.x * 2. + u_time)));
    pct.b = abs(cos(sin(u_time + 2. * st.x) * 10. * cos(st.y + u_time)));
    

    color = mix(colorA, colorB, pct);
    // color = (pct);

    // Plot transition lines for each channel
    // color = mix(color,vec3(1.0,0.0,0.0),plot(st,pct.r));
    // color = mix(color,vec3(0.0,1.0,0.0),plot(st,pct.g));
    // color = mix(color,vec3(0.0,0.0,1.0),plot(st,pct.b));

    gl_FragColor = vec4(color,1.0);

    // gl_FragColor = vec4(
    //     abs(sin(cos(st.y + u_time) * 10. * st.x + u_time)),
    //     abs(cos(sin(st.x + u_time) * 10. * st.y + u_time)),
    //     1.0,
    //     1.0
    // );
}
