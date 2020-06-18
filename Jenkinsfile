
pipeline {

  agent any {

  }
  stages {
    stage('QA') {
      parallel {

        stage('Release') {
          steps{
            if (env.BRANCH_NAME == 'master') {
            echo "Hello master"
            //docker.withRegistry('http://nat01.encowayhb.lokal:5001', 'nexus') {
            //app.push("${env.BUILD_NUMBER}")
            //app.push("latest")
          }

          }
     
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