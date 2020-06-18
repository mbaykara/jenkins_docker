
pipeline {
    agent any

    environment {
        DISABLE_AUTH = 'true'
        DB_ENGINE    = 'sqlite'
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
