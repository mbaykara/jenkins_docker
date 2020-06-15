pipeline {
    agent any 

    
        stage('Docker stage')
            {
               
                stage('Build image')
                {
                    app = docker.build("celcin/compile")
                }
                    
                stage('Push image')
                {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials')
                        {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                        }
                }

            }

    
    
}


