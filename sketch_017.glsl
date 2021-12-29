#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#define PI 3.14159265359

float def(vec2 uv, float f);

void main(void)
{
    vec2 uv = gl_FragCoord.xy / u_resolution;

    vec4 c1 = vec4(0.1922, 0.902, 0.8392, 1.0);
    vec4 c2 = vec4(0.7843, 0.2941, 0.8314, 1.0);
    
    // center
    vec2 p = vec2(.5) - uv;
    // radius
    float rad = length(p)*1.;
    // angle
    float ang = atan(p.x, p.y);
    
    //shape
    float e = def(uv, 0.);
    float e2 = def(uv, PI/6.);
    
    
    // final color
    vec4 color = vec4(e)*c1*c1.a+vec4(e2)*c2*c2.a;
    
    gl_FragColor = color;
}

float def(vec2 uv, float f) {

    const float cant = 5.;
    float e = 0.;
    
    for(float i=0.; i<cant; i++) {
        // center
        vec2 p = vec2(.5, i/cant) - uv;
        // radius
        float rad = length(p)*1.;
        // angle
        float ang = atan(p.x, p.y);
    
        e += sin(ang*5.+f+u_time)+sin(rad*100.+u_time);
    }
    
    e /= cant;
    
    return abs(e);
}