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

         def rootDir = pwd()
         def example = load "${rootDir}@script/master.groovy"
             example.call()
    
         
    }
    stage('Push image') {
       


      }
    } */

 


node {
    // Git checkout before load source the file
    checkout scm


    def rootDir = pwd()
    println("Current Directory: " + rootDir)

    // point to exact source file
     def example = load "${rootDir}/master.groovy"
             example.call()
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