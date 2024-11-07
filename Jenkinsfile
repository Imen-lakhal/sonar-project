pipeline {
    agent any
    stages {
        stage('Clean Workspace') {
            steps {
                script {
                    deleteDir()
                }
            }
        }

        stage("Checkout Source") {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Imen-lakhal/sonar-project.git'
            }
        }

        stage("Install Dependencies") {
            steps {
                script {
                    bat 'npm config get registry'
                    bat "npm config set registry https://registry.npmjs.org/"
                    bat 'npm install -g yarn'
                }
            }
        }

        stage('Run Docker Compose') {
            steps {
                script {
                    bat 'docker-compose build'
                    bat 'whoami'
                    bat 'docker-compose up -d'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                     withCredentials([string(credentialsId: 'test-sonar', variable: 'SONAR_TOKEN')]) {
                     bat """
                        npx sonar-scanner ^
                        -Dsonar.projectKey=sonar-test ^
                        -Dsonar.projectName=sonar-test ^
                        -Dsonar.projectVersion=1.0 ^
                        -Dsonar.sources=. ^
                        -Dsonar.sourceEncoding=UTF-8 ^
                        -Dsonar.token=%SONAR_TOKEN% ^
                        -Dsonar.exclusions=**/node_modules/**,**/pages/**,**/src/**
                    """
                    }
                }
            }
        }
      
    }

    post {
        always {
            script {
                bat 'docker-compose down'
            }
             emailext(
                subject: "Pipline status: ${BUILD_NUMBER}",
                body:'''
                <html>
                    <body>
                        <p> Build status : ${BUILD_STATUS} </p>
                        <p> Build Number : ${BUILD_NUMBER} </p>
                        <p> Check the <a href="${BUILD_URL}"> console output </a>.</p>

                    </body>
                </html>
                ''',
                to: 'mallek.yessmin@gmail.com',
                from: 'mallek.yessmin@gmail.com',
                replyTo : 'mallek.yessmin@gmail.com',
                mimeType : 'text/html' 
            )
            
            
        }
    }
}
