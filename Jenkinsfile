pipeline {
    agent any
    stages {
        stage('Cloning from github (laravel-baseimage)') {
            steps {
                git 'https://github.com/HydroMoon/laravel-baseimage'
            }
        }
        stage('Preparing Docker Buildx...') {
            steps {
                sh 'docker buildx create --use --name multiarch && docker buildx inspect --bootstrap'
            }
        }
        stage('Building & pushing docker image with PHP7.4-FPM as base image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'DockerCredentials', url: 'https://index.docker.io/v1/') {
                        sh 'BASE_IMAGE=php:7.4-fpm VERSION=php-7.4 make build'
                    }
                }
            }
        }
        // stage('Pushing hydromoon/laravel-base:php-7.4 image') {
        //     steps {
        //         script {
        //             withDockerRegistry(credentialsId: 'DockerCredentials', url: 'https://index.docker.io/v1/') {
        //                 customImage = docker.image('hydromoon/laravel-base:php-7.4')
        //                 customImage.push()
        //             }
        //         }
        //     }
        // }
        stage('Building docker image with PHP8.0-FPM as base image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'DockerCredentials', url: 'https://index.docker.io/v1/') {
                        sh 'BASE_IMAGE=php:8-fpm VERSION=php-8.0 make build'
                    }
                }
            }
        }
        // stage('Pushing hydromoon/laravel-base:php-8.0 image') {
        //     steps {
        //         script {
        //             withDockerRegistry(credentialsId: 'DockerCredentials', url: 'https://index.docker.io/v1/') {
        //                 customImage = docker.image('hydromoon/laravel-base:php-8.0')
        //                 customImage.push()
        //             }
        //         }
        //     }
        // }
        stage('Building docker image with PHP8.1-FPM as base image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'DockerCredentials', url: 'https://index.docker.io/v1/') {
                        sh 'BASE_IMAGE=php:8.1-fpm VERSION=php-8.1 make build'
                    }
                }
            }
        }
        // stage('Pushing hydromoon/laravel-base:php-8.1 image') {
        //     steps {
        //         script {
        //             withDockerRegistry(credentialsId: 'DockerCredentials', url: 'https://index.docker.io/v1/') {
        //                 customImage = docker.image('hydromoon/laravel-base:php-8.1')
        //                 customImage.push()
        //             }
        //         }
        //     }
        // }
        stage('Clean dangling images') {
          steps {
            sh '''#!/bin/sh
                    dangling=$(docker images --filter dangling=true -q --no-trunc)
                    if [ -z "$dangling" ]; then
                        echo "No dangling images found."
                    else
                        docker rmi -f $dangling
                        echo "All dangling images deleted successfully!"
                    fi
            '''
          }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            slackSend channel: '#jenkins-pipelines', color: 'good', message: 'Build job completed successfully!', tokenCredentialId: 'Slack Token'
        }
        failure {
            slackSend channel: '#jenkins-pipelines', color: 'danger', message: 'Build job failed', tokenCredentialId: 'Slack Token'
        }
    }
}
