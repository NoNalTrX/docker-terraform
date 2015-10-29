provider "docker" {
    host = "tcp://10.107.2.196:443/"
}
resource "docker_container" "nginx" {
  name = "nginx"
  image = "${docker_image.nginx.latest}"
  must_run = true
  hostname = "Amsterdam"

  ports = {
	internal="80"
	external="80"
  }
  volumes = {
    from_container = "${docker_container.app1.id}"
  	read_only = "true"
  }
   
  volumes = {
    from_container = "${docker_container.app2.id}"
    read_only = "true"
  }


}

resource "docker_container" "app1" {
  name = "app1"
  image = "${docker_image.app1.latest}"
  must_run = true
  hostname = "London"

  volumes = {
        container_path = "/var/run/app1"
  }
 
  volumes = {
        container_path = "/var/www/app1"
  }
  
  volumes = {
        container_path = "/etc/nginx/sites-enabled/app1/"
  }

}

resource "docker_container" "app2" {
  name = "app2"
  image = "${docker_image.app2.latest}"
  must_run = true
  hostname = "Paris"

  volumes = {
        container_path = "/var/run/app2"
  }

  volumes = {
        container_path = "/var/www/app2"
  }

  volumes = {
        container_path = "/etc/nginx/sites-enabled/app2/"
  }
}

resource "docker_image" "app2" {
  name = "app2:latest"
}

resource "docker_image" "nginx" {
  name = "mynginx:latest"
}

resource "docker_image" "app1" {
  name = "app1:latest"
}
