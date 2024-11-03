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
                git branch: 'develop', credentialsId: 'github', url: 'https://github.com/henisahar/testproject.git'
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
                    withCredentials([string(credentialsId: 'test-sonar', variable: 'sonarqube_token')]) {
                        bat "npx sonar-scanner -Dsonar.projectKey=sonar-test -Dsonar.projectName=sonar-test -Dsonar.projectVersion=1.0 -Dsonar.sources=. -Dsonar.sourceEncoding=UTF-8 -Dsonar.token=%sonarqube_token% -Dsonar.exclusions=**/node_modules/**"
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
        }
    }
}
