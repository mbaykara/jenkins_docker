

node() {
  //def app
  checkout scm

  def String dockerImage = 'celcin/runtime-tool'
  def String dockerArgs = '' 
  //def String devEnv = 'CONAN_USER_HOME=/tmp/conan/ CONAN_NON_INTERACTIVE=1 CCACHE_DIR=/tmp/ccache/'
  
  stage('Testing') {
    parallel (
      'Release Build': {
        docker.image(dockerImage).inside(dockerArgs) {
          sh 'mkdir -p /tmp/build-release'
          //sh "cd /tmp/build-release && ${devEnv} cmake -DCMAKE_BUILD_TYPE=Release ${WORKSPACE}/runtime && ${devEnv} cmake --build . && ${devEnv} cmake --build . && ctest --output-on-failure"
          sh "#!/bin/bash  cd /tmp/build-release && echo 'test' >> t.txt "
        }
      },
      'Complexity': {
        docker.image(dockerImage).inside(dockerArgs) {
         sh "#!/bin/bash  cd /tmp/build-release && cat t.txt"
          
          //sh "cd /tmp/build-complexity && ${devEnv} cmake -DCMAKE_BUILD_TYPE=Release ${WORKSPACE}/runtime && ${devEnv} cmake --build . --target complexity"
        }
      }      
    )
  }
}
