pipeline{
    agent {
        docker {
            image 'maven'
            args '-v $HOME/.m2:/root/.m2'
        }
    }

    stages{

        stage('quality gate status check'){
            steps{
                script{
                    withSonarQubeEnv('sonarserver') {
                        sh "mvn clean sonar:sonar"
                    }
                    timeout(time: 1, unit: 'HOURS'){
                    def qg = waitForQualityGate()
                    if (qg.status != 'ok'){
                       error "piplline aborted due to quality gate failures : ${qg.status}"
                        }
                    }
                     sh "mvn clean install"
                }
            }
        }
    }
}
