#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#define PI 3.14159265358979323846

vec2 rotate2D(vec2 _st, float _angle){
    _st -= 0.5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
    return fract(_st);
}

float box(vec2 _st, vec2 _size, float _smoothEdges){
    _size = vec2(0.5)-_size*0.5;
    vec2 aa = vec2(_smoothEdges*0.5);
    vec2 uv = smoothstep(_size,_size+aa,_st);
    uv *= smoothstep(_size,_size+aa,vec2(1.0)-_st);
    return uv.x*uv.y;
}

void main(void){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    // Divide the space
    st = tile(st,4.);

    // Use a matrix to rotate the space 45 degrees
    st = rotate2D(st,PI*.25);

    // float edge = fract(abs(sin(u_time+st.x)));
    // edge = clamp(edge,0.05, 0.5);

    
    // st.x += sin(u_time+st.x)*.2 + cos(u_time+st.y)*.5;
    // st.y += mod(st.y, .5);

    // Draw a square
    color = vec3(box(st,vec2(0.7),0.03));

    // color.r = sin(u_time);
    // color.g = ;
    // color.b = ;

    // color = vec3(st,0.0); // show space divisions

    gl_FragColor = vec4(color,1.0);
}