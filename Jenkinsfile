
node  {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("runtime-development-tools")
    }
    stage('Push image') {
        if(env.GIT_BRANCH == "master"){
        docker.withRegistry('http://172.17.0.2:8123', 'nexus') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
      }
    }
}




/* 
pipeline {
    agent any

    environment {
        DISABLE_AUTH = 'true'
    }

    stages {

        stage('Build image') 
        {
            echo "${env.BRANCH_NAME}"
            //app = docker.build("runtime-development-tools")

        }
        stage('Build') 
        {
            steps 
            {
                echo "${env.BRANCH_NAME}"
                echo "${env.GIT_BRANCH}"
            }
        }
    }
}
 */