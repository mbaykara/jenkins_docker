node {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("runtime-tooling")
    }
    stage('Push image') {
        docker.withRegistry('http://nat01.encowayhb.lokal:8081/repository/docker/', 'nexus') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}



