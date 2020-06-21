 
node  {
    def app
    stage('Clone repository') {
        
         echo " ${env.BRANCH_NAME}"
        checkout scm
    }
    stage('Build image') {

         app = docker.build("runtime-development-tools")
        echo "${env.GIT_BRANCH}"
         echo "${env.BRANCH_NAME}"
    }
    stage('Push image') {
       def externalMethod = evaluate readFile("master.groovy")


      }
    }

 



/*
pipeline {
    agent any

    environment {
        DISABLE_AUTH = 'true'
    }

    stages {

        stage('expression-branch') {
            agent any
            when {
                expression {
                    return env.BRANCH_NAME == 'null';
                }
            }
            steps {
                echo 'run this stage - when branch is not equal to master'
            }
        }

    }
}

*/