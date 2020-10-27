

node() {
  //def app
  checkout scm

  def String dockerImage = 'celcin/runtime-tool'
  def String dockerArgs = "-v ${WORKSPACE}/conan:/tmp/conan" 
  def String devEnv = 'CONAN_USER_HOME=/tmp/conan/ CONAN_NON_INTERACTIVE=1 CCACHE_DIR=/tmp/ccache/'
  //def String devEnv = 'CONAN_USER_HOME=/tmp/conan/ CONAN_NON_INTERACTIVE=1 CCACHE_DIR=/tmp/ccache/'
  
  stage('Testing') {
    parallel (
      'Release Build': {
        docker.image(dockerImage).inside(dockerArgs) {
         
          //sh "cd /tmp/build-release && ${devEnv} cmake -DCMAKE_BUILD_TYPE=Release ${WORKSPACE}/runtime && ${devEnv} cmake --build . && ${devEnv} cmake --build . && ctest --output-on-failure"
          sh '''#!/bin/bash
                 mkdir p && cd p && ${devEnv} BUILDNUMBER=${env.BUILD_NUMBER} /usr/bin/conan  new hello/0.1 -t 
         '''
          //sh "${devEnv} BUILDNUMBER=${env.BUILD_NUMBER} /usr/bin/conan create "
          //sh "#!/bin/bash  mkdir -p /tmp/build-release && cd /tmp/build-release && echo 'test' >> t.txt "
        }
      },
      'Complexity': {
        docker.image(dockerImage).inside(dockerArgs) {
         //sh "#!/bin/bash  cd /tmp/build-release && cat t.txt"
          sh " ls /tmp/conan"
          //sh "cd /tmp/build-complexity && ${devEnv} cmake -DCMAKE_BUILD_TYPE=Release ${WORKSPACE}/runtime && ${devEnv} cmake --build . --target complexity"
        }
      }      
    )
  }
}
