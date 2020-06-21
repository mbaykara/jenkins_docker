/* 
node  {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        echo "${env.GIT_BRANCH}"
         echo "${env.BRANCH_NAME}"
    }
    stage('Push image') {
        if(env.GIT_BRANCH == "master"){
        
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

        stage('expression-branch') {
            agent any
            when {
                expression {
                    return env.BRANCH_NAME != 'master';
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