node {
    def app
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {

        app = docker.build("runtime-development-test")
    }
    stage('Push image') {
        //if(env.BRANCH_NAME == 'master'){
        when {env.BRANCH_NAME == 'master'}
        steps {

docker.withRegistry('http://nat01.encowayhb.lokal:5001', 'nexus') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
        }
        
    
    
  }
}



 