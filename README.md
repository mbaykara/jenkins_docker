# jenkins_docker

* create docker host repo
* create user
* give right permission


node  {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("runtime-development-tools")
    }
    stage('Push image') {
        if(env.BRANCH_NAME == "master"){
        docker.withRegistry('http://nat01.encowayhb.lokal:5001', 'dockerUser') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
      }
    }
}
