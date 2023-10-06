void main() {

    // Find the pixel at the coordinate of the actual texture
    vec4 val = texture2D(u_texture, v_tex_coord);

    // If the color value of that pixel is 0,0,0
    if (val.r == 0.0 && val.g == 0.0 && val.b == 0.0) {
        // Turn the pixel off
        gl_FragColor  = vec4(0.0,0.0,0.0,0.0);
    }
    else {
        // Otherwise, keep the original color
        gl_FragColor = val;
    }
}
