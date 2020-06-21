
pipeline {
    agent any

    environment {
        DISABLE_AUTH = 'true'
    }

    stages {

        stage('Build image') {
            echo "${env.BRANCH_NAME}"
            //app = docker.build("runtime-development-tools")

        }
        stage('Build') {
            steps {
                echo "${env.BRANCH_NAME}"
                echo "${env.GIT_BRANCH}"
                //sh 'printenv'
            }
        }
    }
}
