
pipeline {
    agent any

    environment {
        DISABLE_AUTH = 'true'
        DB_ENGINE    = 'sqlite'
    }

    stages {
        stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        //app = docker.build("runtime-development-tools")
        echo "${env.BRANCH_NAME}"
        echo "${env.GIT_BRANCH}"
    }
        stage('Build') {
            steps {
                sh 'printenv'
            }
        }
    }
}
