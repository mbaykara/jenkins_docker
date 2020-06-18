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
          
           when {
                // Only say hello if a "greeting" is requested
                expression {env.BRANCH_NAME == 'master' }
            }
              steps {
                
                echo "Hello master"
                //echo "${branch}"
                
            }

          }
          
        }
    
}