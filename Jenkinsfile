
pipeline {
    
  agent {

  }
  stages {
    stage('QA') {
      parallel {

         stage('Release') {
 
             when {
                 branch 'master'
             }
               echo "Hello master"
                docker.withRegistry('http://nat01.encowayhb.lokal:5001', 'nexus') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
        } 

     }
          post {
        failure {
            echo 'This build has failed. See logs for details.'
        }
      }
    }

     stage('Deploy Conan Packages') {
          parallel {


     stage('Deploy Conan Package') {
            steps {

              sh " echo Building conan package..."
              
          }
          environment {
            CONAN_USER_HOME = "/tmp/build-release"
            
           } 
        }  
      }
    }
  }
}