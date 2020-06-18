node {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("docker/runtime-development-tools")
    }
    stage('Push image') {
        docker.withRegistry('http://nat01.encowayhb.lokal:5001', 'nexus') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}



