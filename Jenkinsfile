pipeline {
    agent any
    stages {
        stage('Cloning from github (laravel-baseimage)') {
            steps {
                git 'https://github.com/HydroMoon/laravel-baseimage'
            }
        }
        stage('Build & Pushing Laravel Baseimage') {
            matrix {
                axes {
                    axis {
                        name 'BASE_IMAGE_AND_VERSION'
                        values 'php:7.4-fpm;php-7.4', 'php:8-fpm;php-8.0', 'php:8.1-fpm;php-8.1', 'php:8.2-fpm;php-8.2'
                    }
                }
                stages {
                    stage('build') {
                        steps {
                            script {
                                withDockerRegistry(credentialsId: 'DockerCredentials', url: 'https://index.docker.io/v1/') {
                                    sh 'docker buildx create --use && docker buildx inspect --bootstrap'
                                    sh '''#!/bin/bash
                                        IN=${BASE_IMAGE_AND_VERSION}
                                        arrIN=(${IN//;/ })
                                        BASE_IMAGE=${arrIN[0]} VERSION=${arrIN[1]} make build
                                    '''
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}