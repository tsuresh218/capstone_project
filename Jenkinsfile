node {
  stage('Checkout') {
    checkout scm
  }
  stage('Build & Push image') {
    if(env.Branch_NAME== 'dev') {
      docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_login') {
        def appImage = docker.build("tsuresh218/dev:$env.BUILD_ID}")
        appImage.push()
      }
    } else if(env.Branch_NAME== 'master') {
      docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_login') {
        def appImage = docker.build("tsuresh218/prod:$env.BUILD_ID}")
        appImage.push()
      }
    } else {
      echo "No Operation for this branch"
    }
  }
}
