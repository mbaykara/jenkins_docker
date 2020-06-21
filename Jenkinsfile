 
node  {
    def app
    stage('Clone repository') {
        
        checkout scm
    }
    stage('Build image') {

         app = docker.build("runtime-development-tools")
   
         
    }
    stage('Push image') {
       
  if(env.BRANCH_NAME == "master"){
       
            docker.withRegistry(http://172.17.0.2:8123, 'nexus') {
                image.push("${env.BUILD_NUMBER}")
                image.push("latest")
            
        
    }

      }
    } 

 


