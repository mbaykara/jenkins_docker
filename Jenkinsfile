node {
    def mosaiq-app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        mosaiq-app = docker.build("celcin/compile")
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            mosaiq-app.push("${env.BUILD_NUMBER}")
            mosaiq-app.push("latest")
        }
    }
}



