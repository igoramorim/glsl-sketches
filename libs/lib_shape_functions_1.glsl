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

    // float y = st.x;
    // float y = pow(st.x, 5.0); // 0.5
    // float y = exp(-st.x * PI);
    // float y = log(st.x * PI);
    // float y = sqrt(st.x);
    
    // step will return 0.0 if the second parameter >= the first
    // float y = step(0.4, st.x);
    // float y = step(sin(u_time), st.x);
    
    // smoothstep interpolate the 3rd parameter between the first and second
    // map() in processing is similar
    // float y = smoothstep(0.1, 0.9, st.x);
    // float y = smoothstep(0.2,0.5,st.x) - smoothstep(0.5,0.8,st.x);
    // float y = smoothstep(0.1, 0.9, sin(u_time));
    
    // sine and cosine
    // float y = sin(u_time);
    // float y = cos(u_time);
    // float y = sin(u_time + st.x);
    // float y = sin(u_time + st.x * PI);
    // float y = abs(sin(u_time + st.x * PI) * 0.5); // 2.0
    // float y = abs(sin(u_time + st.x * PI) * sin(u_time));
    // float y = fract(sin(u_time + st.x * PI));
    
    // other functions
    
    // https://thebookofshaders.com/glossary/?search=mod
    // float y = mod(sin(u_time + st.x * PI), 0.5); 
    // float y = mod(st.x, 0.5);
    
    // https://thebookofshaders.com/glossary/?search=fract
    // float y = fract(st.x + u_time); 
    // float y = fract(st.x + sin(u_time));
    // float y = fract(st.x + u_time) * sin(u_time) + 0.5;
    
    // https://thebookofshaders.com/glossary/?search=ceil
    // https://thebookofshaders.com/glossary/?search=floor
    // float y = fract(ceil(st.x) + floor(st.x) * sin(u_time));
    // float y = mod(ceil(st.x) + floor(st.x) * sin(u_time), 0.5);
    
    // https://thebookofshaders.com/glossary/?search=sign
    // float y = sign(st.x); 
    
    // https://thebookofshaders.com/glossary/?search=abs
    // float y = abs(st.x); 
    // float y = abs(st.x - 0.5);
    // float y = abs(st.x - 0.5) + sin(u_time);
    // float y = abs(st.x - 0.5) + smoothstep(-1., 1., sin(u_time));
    
    // https://thebookofshaders.com/glossary/?search=clamp
    // float y = clamp(st.x, 0.0, sin(u_time)); 
    // float y = mod(clamp(st.x, 0.0, sin(u_time)), 0.5);
    
    // https://thebookofshaders.com/glossary/?search=min
    // float y = min(0.5, st.x); 
    
    // https://thebookofshaders.com/glossary/?search=max
    float y = max(0.5, st.x);

    vec3 color = vec3(y);

    // Plot a line
    float pct = plot(st,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

	gl_FragColor = vec4(color,1.0);
}
