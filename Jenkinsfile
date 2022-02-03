def getDockerTag() {
    def tag = sh script: 'git rev-parse HEAD', returnStdout:true
    return tag
}
pipeline{
    agent any
    environment{
        Dokcer_tag = getDockerTag()
    }

    stages{

        stage('build'){
            agent {
               docker {
                 image 'maven'
                 args '-v $HOME/.m2:/root/.m2'
               }
           }
            steps{
                script{
                    sh "mvn clean install"
                }
            }
        }
        stage('deploy to container'){
            steps{
                script{
                    sh "docker build -t jayapallion/completeci-cd:$Docker_tag ."
                    withCredentials([string(credentialsId: 'Docker_password', variable: 'Docker_password')]){
                    sh "docker login -u jayapallion -p $Docker_password"
                    sh "docker push jayapallion/completeci-cd:$Docker_tag" 
                    }
                }
            }
        } 
    }
}
