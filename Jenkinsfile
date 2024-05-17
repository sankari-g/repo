pipeline {
  agent { label 'agent1' }

  stages {
    stage ('Main build') {
      steps {
        echo 'Hello from Main Build '
      }
    }
    
    stage ('Readme') {
      steps {
        sh 'cat README.md'
      }
    }
    stage ('for jenkins branch') {
      when {
        branch 'main'
      }
      steps {
        input (message: 'Sample environment', ok: 'Execute')
        echo 'Executed'
      }
    }
    stage ('print message'){
      steps {
        echo 'Hello from Jenkins'  
      }
    }
  }
}
