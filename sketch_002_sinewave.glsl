// Source unknown

#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;

uniform vec2 u_resolution;

#define speed 0.1	
#define freq 2.7
#define amp 2.7


void main( void ) {

	vec2 st = (gl_FragCoord.xy / u_resolution.xy) * 2. - 1.;
	st.x *= u_resolution.x / u_resolution.y;
	
	float sx = (amp) * 1.0 * sin(5.0 * (freq) * (st.x) - 27. * (speed) * u_time);

    // float sx = (amp) * sin(st.x - 27. * (speed) * u_time);
	
	float dy = 54. / (54. * abs(27. * st.y - sx));

    // float dy = 54. / (54. * abs(27. * st.y - sx));
	
	dy += 1./ (60. * length(st - vec2(st.x, 0.)));
	
	gl_FragColor = vec4( (st.x + 0.27) * dy, 0.27 * dy, dy, 1.0 );

    // gl_FragColor = vec4( (sx), 0.27, 1., 1.0 );

}