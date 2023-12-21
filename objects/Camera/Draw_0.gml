/// @description Draw the 3D world

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
draw_clear(c_white);
gpu_set_texrepeat(true);

// 3D projections require a view and projection matrix
var camera = camera_get_active();

var xfrom = Player.x;
var yfrom = Player.y;
var zfrom = Player.z + 64;
var xto = xfrom - dcos(Player.look_dir) * dcos(Player.look_pitch);
var yto = yfrom + dsin(Player.look_dir) * dcos(Player.look_pitch);
var zto = zfrom + dsin(Player.look_pitch);

var view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
var proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 10_000);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

shader_set(shd_basic_3d_stuff);

vertex_submit(vb_ground, pr_trianglelist, sprite_get_texture(spr_ground, 0));

var rotation = current_time / 1000 * 60;
matrix_set(matrix_world, matrix_build(100, 100, 32, 30, 30, rotation, 1, 1, 1));
vertex_submit(vb_sword, pr_trianglelist, sprite_get_texture(spr_sword, 0));

matrix_set(matrix_world, matrix_build(50, 150, 32, 30, 30, rotation, 1, 1, 1));
vertex_submit(vb_sword, pr_trianglelist, sprite_get_texture(spr_sword, 0));
vertex_submit(vb_sheath, pr_trianglelist, sprite_get_texture(spr_sheath, 0));

matrix_set(matrix_world, matrix_build_identity());
shader_reset();
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);