node () {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("runtime-development-tools", "./Dockerfiles/runtime-tooling.dockerfile")
    }
    stage('Push image') {
        if(env.BRANCH_NAME == "master"){
        docker.withRegistry('http://172.17.0.2:8080', 'dockerUser') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
      }
    }
}








