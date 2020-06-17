node {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("runtime-tooling")
    }
    stage('Push image') {
        docker.withRegistry('http://192.168.1.221:8081', 'nexus') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}



