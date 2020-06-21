 
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
       def externalMethod = load("master.groovy")
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


/*        stage('Build')
       {
            steps
           {
               echo "${env.GIT_BRANCH}"
               // if("${env.GIT_BRANCH}" == 'origin/master' ){
               //    echo "Hello master"
               //}
           }

           //echo "${env.GIT_BRANCH}"
           when{
               branch 'origin/master'
           }
           steps {
               echo 'run this stage - ony if the branch = master branch'
           }
       } */