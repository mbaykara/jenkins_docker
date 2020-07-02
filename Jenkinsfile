node () {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("celcin/runtime-development-tools", "./Dockerfiles/mehmet.dockerfile")
    }
    stage('Push image') {
        if(env.BRANCH_NAME == "master"){
        docker.withRegistry('https://registry-1.docker.io/v2/', 'celcin') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
      }
    }
}








