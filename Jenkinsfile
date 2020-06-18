node () {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("runtime-development-tools")
        echo "${env.BRANCH_NAME}"
    }
    stage('Push image') {
        if(env.GIT_BRANCH=="origin/master"){
          echo "Hello master"
      
        }
      }
    }

