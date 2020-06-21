/* 
node  {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("runtime-development-tools")
         echo "${env.GIT_BRANCH}"
         echo "${env.BRANCH_NAME}"
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
 */




pipeline {
    agent any

    environment {
        DISABLE_AUTH = 'true'
    }

    stages {

        stage('Build') 
        {
            steps 
            {
               echo "${env.GIT_BRANCH}"
                if(env.GIT_BRANCH) == origin/master ){
                    echo "Hello master"
                }
            }
        }
    }
}
