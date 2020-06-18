node {
    def app
    def branchName = getCurrentBranch()

    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("runtime-development-test")
    }
    stage('Push image') {
        
        if ( branchName == "master") {
              echo "Hello  master"
              echo "${env.BRANCH_NAME}" 
        } else {
            echo "Hello master"
            docker.withRegistry('http://nat01.encowayhb.lokal:5001', 'nexus') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }
        }


    }
}



