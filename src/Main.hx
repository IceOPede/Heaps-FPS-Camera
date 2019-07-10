import hxd.Math;
import h3d.scene.Mesh;
import h3d.Vector;

class Main extends hxd.App {
	var skyTexture:h3d.mat.Texture;
	//
	var cameraPos:Vector;
	var cameraFront:Vector;
	var cameraDirection:Vector;
	//
	var cameraUp:Vector;
	var cameraRight:Vector;
	//
	var yaw:Float;
	var pitch:Float;
	//
	var lastX:Float;
	var lastY:Float;
	//
	var sensitivity = 1;

	override function init() {
		this.cameraPos = new Vector(0.0, 0, 0.0);

		this.cameraFront = new Vector(0.0, -1.0, 0.0);
		this.cameraDirection = this.cameraPos.sub(this.cameraFront);

		this.cameraDirection.normalize();

		this.cameraUp = new Vector(0.0, 0.0, 1.0);

		this.cameraRight = this.cameraUp.cross(this.cameraDirection);
		this.cameraRight.normalize();

		s3d.camera.pos = this.cameraPos;
		s3d.camera.up = this.cameraUp;
		s3d.camera.target = this.cameraPos.add(this.cameraFront);

		//

		var prim = new h3d.prim.Cube();
		prim.translate(0, 0, 0);
		prim.unindex();
		prim.addNormals();
		prim.addUVs();

		var mainObj = new Mesh(prim, s3d);
		mainObj.material.color.setColor(0xFFB280);
		mainObj.x = 0;
		mainObj.y = -2;
		mainObj.z = 0;
		mainObj.scale(0.6);
		mainObj.material.shadows = false;
		//
		var obj = new Mesh(prim, s3d);
		obj.material.color.setColor(0xFF0000);
		obj.x = 1;
		obj.y = -2;
		obj.z = 1;
		obj.scale(0.6);
		obj.material.shadows = false;
		//
		lastX = s2d.width / 2;
		lastY = s2d.height / 2;
		yaw = -90;
		pitch = 0.0;
	}

	var firstMouse = true;

	override function update(dt:Float) {
		// Camera movement
		var cameraSpeed = 2.5 * dt;
		if (hxd.Key.isDown(hxd.Key.W)) {
			var temp = this.cameraFront.clone();
			temp.scale3(cameraSpeed);
			this.cameraPos = this.cameraPos.add(temp);
		}
		if (hxd.Key.isDown(hxd.Key.S)) {
			var temp = this.cameraFront.clone();
			temp.scale3(cameraSpeed);
			this.cameraPos = this.cameraPos.sub(temp);
		}
		if (hxd.Key.isDown(hxd.Key.A)) {
			var temp = this.cameraFront.cross(this.cameraUp);
			temp.normalize();
			temp.scale3(cameraSpeed);
			this.cameraPos = this.cameraPos.add(temp);
		}
		if (hxd.Key.isDown(hxd.Key.D)) {
			var temp = this.cameraFront.cross(this.cameraUp);
			temp.normalize();
			temp.scale3(cameraSpeed);
			this.cameraPos = this.cameraPos.sub(temp);
		}

		// Look around

		var xpos = s2d.mouseX;
		var ypos = s2d.mouseY;
		if (firstMouse) {
			lastX = xpos;
			lastY = ypos;
			firstMouse = false;
		}
		var xoffset = xpos - lastX;
		var yoffset = lastY - ypos;
		lastX = xpos;
		lastY = ypos;

		xoffset *= sensitivity;
		yoffset *= sensitivity;

		yaw += xoffset;
		pitch += yoffset;

		if (pitch > 89.0) {
			pitch = 89.0;
		};
		if (pitch < -89.0) {
			pitch = -89.0;
		};

		var newDir = new Vector();
		newDir.x = Math.cos(Math.degToRad(yaw)) * Math.cos(Math.degToRad(pitch));
		newDir.y = Math.sin(Math.degToRad(yaw)) * Math.cos(Math.degToRad(pitch));
		newDir.z = Math.sin(Math.degToRad(pitch));
		newDir.normalize();
		this.cameraFront = newDir;

		s3d.camera.pos = this.cameraPos;
		s3d.camera.up = this.cameraUp;
		s3d.camera.target = this.cameraPos.add(this.cameraFront);
	}

	static function main() {
		new Main();
	}
}
