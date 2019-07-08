import h3d.scene.Mesh;
import haxe.Timer;
import h3d.Vector;

class Main extends hxd.App {
	var skyTexture:h3d.mat.Texture;
	//
	var timer:Timer;
	var time = 0;
	//
	var cameraPos:Vector;
	var cameraTarget:Vector;
	var cameraDirection:Vector;
	var cameraUp:Vector;
	var cameraRight:Vector;

	override function init() {
		this.cameraPos = new Vector(0.0, -10.0, 0.0);
		this.cameraTarget = new Vector(0.0, 1.0, 0.0);

		this.cameraDirection = this.cameraPos.sub(this.cameraTarget);
		this.cameraDirection.normalize();

		this.cameraUp = new Vector(0.0, 0.0, 1.0);

		this.cameraRight = this.cameraUp.cross(cameraDirection);
		this.cameraRight.normalize();

		s3d.camera.pos = cameraPos;
		s3d.camera.up = cameraUp;
		s3d.camera.target = cameraTarget;

		//

		var prim = new h3d.prim.Cube();
		prim.translate(0, 0, 0);
		prim.unindex();
		prim.addNormals();
		prim.addUVs();

		var obj2 = new Mesh(prim, s3d);
		obj2.material.color.setColor(0xFFB280);
		obj2.x = 0;
		obj2.y = 0;
		obj2.z = 0;
		obj2.scale(0.6);
		obj2.material.shadows = false;
		
	}

	override function update(dt:Float) {
		
	}

	static function main() {
		new Main();
	}
}
