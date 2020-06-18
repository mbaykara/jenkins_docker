pipeline {
    agent any
    stages {
        stage('Example Build') {
            steps {
                echo 'Hello World'
                echo "${branch}"
            }
        }
        stage('Example Deploy') {
            when {
                branch 'master'
               
            }
            steps {
                echo "Hello master"
                echo "${branch}"
            }
        }
    }
}