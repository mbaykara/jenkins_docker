pipeline {
    agent any
    stages {
        stage('Example Build') {
            steps {
                echo 'Hello World'
                echo "${env.BRANCH_NAME}"
            }
        }
        stage('Example Deploy') {
          
              steps {
                if (env.BRANCH_NAME == "master") {
                echo "Hello master"
                //echo "${branch}"
                }
            }

          }
          
        }
    
}