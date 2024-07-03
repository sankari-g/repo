pipeline {
    environment {
        BUNDLE_PATH = '/var/cache/bundler'
    }
    agent { docker { 
        image 'ruby:2.7.6' 
        args '-v /var/run/docker.sock:/var/run/docker.sock \
              -v /var/cache/bundler/2.7:/var/cache/bundler/\
              -v /var/secrets:/var/secrets \
              -v /home/jenkins-github-sankari/.ssh/:/root/.ssh/ \
              -v /home/jenkins-github-sankari/.docker:/root/.docker/'
                   }
          }
    stages {
        stage('build') {
            steps {
                sh 'ruby --version'
                sh 'gem install bundler -v 2.3.25'
                sh 'bundle install'
                sh 'bundle exec rspec'
            }
        }
    }
}
