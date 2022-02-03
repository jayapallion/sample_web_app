def getDockerTag {
    def tag = sh script: 'git rev-parse HEAD', returnStdout:true
    return tag
}
pipeline{
    agent {
        docker {
            image 'maven'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    environment{
        Dokcer_tag = getDockerTag()
    }

    stages{

        stage('build'){
            steps{
                script{
                    sh "mvn clean install"
                }
            }
        }
        stage('deploy to container'){
            steps{
                script{
                    docker build . -t jayapallion/completeci-cd:Docker_tag
                    withCredentials([string(credentialsId: 'Docker_password', variable: 'Docker_password')])
                    docker login -u jayapallion -p $Docker_password
                    docker push jayapallion/completeci-cd:Docker_tag
                }

            }
        } 
    }
}
