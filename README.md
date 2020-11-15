# jenkins_docker

* create docker host repo
* create user
* give right permission

`docker run  -u root -p 8080:8080 -v $(pwd)/jenkins:/var/jenkins_home -v $(which docker):/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME":/home jenkins/jenkins
`
