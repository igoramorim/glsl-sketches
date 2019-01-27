// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

// Following functions by Iñigo Quiles
// http://www.iquilezles.org/www/articles/functions/functions.htm
float impulse(float k, float x) {
    float h = k * x;
    return h * exp(1. - h);
}

float cubicPulse(float c, float w, float x) {
    x = abs(x - c);
    if (x > w) return 0.;
    x /= w;
    return 1. - x * x * (3. - 2. * x);
}

float expStep(float x, float k, float n) {
    return exp(-k * pow(x, n));
}

float parabola(float x, float k) {
    return pow(4. * x * (1. - x), k);
}

float pcurve(float x, float a, float b) {
    float k = pow(a+b, a+b) / (pow(a, a) * pow(b, b));
    return k * pow(x, a) * pow(1. - x, b);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    float s = abs(sin(u_time));

    // float y = impulse(12., st.x);
    
    // float y = cubicPulse(.5, .2, st.x);
    
    // float y = expStep(st.x, 10., 1.);
    
    // float y = parabola(st.x, 1.);
    
    float y = pcurve(st.x, 3., 1.);

    vec3 color = vec3(y);

    float pct = plot(st,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color,1.0);
}
