pipeline {
    agent any 

    stages {

            stage('Build image') {
  
            
  
             stage('Build image') {
                    app = docker.build("celcin/compile")
                 }
             stage('Push image') {
        
                docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
             }
            }

         }

     }
    
}


