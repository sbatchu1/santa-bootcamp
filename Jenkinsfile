pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                echo 'building..'
                sh 'make -f Makefile'
            }
        }
    }
}