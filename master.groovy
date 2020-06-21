def call() {
    echo "Hello Groovy"
    if(env.BRANCH_NAME == "master"){
       // withCredentials([string(credentialsId: 'DOCKER_REPOSITORY_URL', variable: 'DOCKER_REPOSITORY_URL')]) {
            docker.withRegistry("${DOCKER_REPOSITORY_URL}", 'nexus') {
                image.push("${env.BUILD_NUMBER}")
                image.push("latest")
            }
        
    }
}
return this