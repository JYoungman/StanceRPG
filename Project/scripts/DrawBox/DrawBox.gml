///DrawBox(x, y, width, height, color)

function DrawBox(x, y, width, height, color){
	draw_rectangle_color(x, y, x+width, y+height, color, color, color, color, false);
}