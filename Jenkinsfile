@Library('Jenkins-shared-lib@main') _
pipeline {
    agent any

    options {
        timeout(time: 30, unit: 'MINUTES')
        timestamps()
    }
    environment {
        DOCKER_IMAGE_FRONTEND_NAME= 'hyysuresh/food-delivery-frontend'
        DOCKER_IMAGE_BACKEND_NAME = 'hyysuresh/food-delivery-backend'
        DOCKER_IMAGE_ADMIN_NAME = 'hyysuresh/food-delivery-admin'
        DOCKER_IMAGE_TAG = '${BUILD_NUMBER}'
        JOB_NAME = 'jenkins-pipeline-food-delivery'
        GIT_BRANCH = 'main'
        BUILD_URL = '${BUILD_URL}'
    }
    stages {
        stage('Check  ci skip') {
            steps {
                script {
                    def commitMessage = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
                    echo "Last git coomit message: ${commitMessage}"
                    if (commitMessage.contains('[ci skip]') || commitMessage.contains('[skip ci]')) {
                        echo "Found CI skip directive in commit message, aborting build"
                        currentBuild.result = 'ABORTED'
                        error("Build skipped due to [ci skip] directive")
                    }
                }
            }
        }
        stage("clean workspace") {
            steps {
                cleanWs()
            }
        }
        stage('Checkout Code') {
            steps {
                script {
                    checkoutRepo()
                }
            }
        }
        stage('build Image') {
            parallel {
                stage('frontend image build') {
                    steps {
                        script {
                            buildDockerImage (
                                imageName: env.DOCKER_IMAGE_FRONTEND_NAME,
                                imageTag: env.DOCKER_IMAGE_TAG,
                                dockerfile: 'frontend/Dockerfile',
                                context: '.'
                            )
                        }
                    }
                }
                stage('backend image build') {
                    steps {
                        script {
                            buildDockerImage (
                                imageName: env.DOCKER_IMAGE_BACKEND_NAME,
                                imageTag: env.DOCKER_IMAGE_TAG,
                                dockerfile: 'backend/Dockerfile',
                                context: '.'
                            )
                        }
                    }
                }
                stage('admin image build') {
                    steps {
                        script {
                            buildDockerImage (
                                imageName: env.DOCKER_IMAGE_ADMIN_NAME,
                                imageTag: env.DOCKER_IMAGE_TAG,
                                dockerfile: 'admin/Dockerfile',
                                context: '.'
                            )
                        }
                    }
                }
            }    
        }
        stage('Run Unit Tests'){
            steps {
                script {
                    runUnitTests()
                }
            }
        }
        stage('Security Scan with Trivy') {
            steps {
                script {
                    sh "mkdir -p trivy-result"
                    echo "start for checking security"
                    
                    trivyScan(
                        imageName: env.DOCKER_IMAGE_FRONTEND_NAME,
                        imageTag: env.DOCKER_IMAGE_TAG,
                        threshold: 150,
                        severity: 'HIGH,CRITICAL'
                        
                    )
                    echo "scaning for backend"
                    trivyScan(
                        imageName: env.DOCKER_IMAGE_BACKEND_NAME,
                        imageTag: env.DOCKER_IMAGE_TAG,
                        threshold: 150,
                        severity: 'HIGH,CRITICAL'
                    )
                    echo "scaning for admin"
                    trivyScan(
                        imageName: env.DOCKER_IMAGE_ADMIN_NAME,
                        imageTag: env.DOCKER_IMAGE_TAG,
                        threshold: 150,
                        severity: 'HIGH,CRITICAL'
                    )
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'trivy-results/*.json,trivy-results/*.html', allowEmptyArchive: true
                }
            }
        }
        stage('Push to DockerHub') {
            parallel {
                stage ('frontend image push') {
                    steps {
                        script {
                            pushDockerImage (
                                imageName: env.DOCKER_IMAGE_FRONTEND_NAME,
                                imageTag: env.DOCKER_IMAGE_TAG,
                                credentails: 'DockerHubCreds'
                            )
                        }
                    }
                }
                stage ('backend image push') {
                    steps {
                        script {
                            pushDockerImage (
                                imageName: env.DOCKER_IMAGE_BACKEND_NAME,
                                imageTag: env.DOCKER_IMAGE_TAG,
                                credentails: 'DockerHubCreds'
                            )
                        }
                    }
                }
                stage ('admin image push') {
                    steps {
                        script {
                            pushDockerImage (
                                imageName: env.DOCKER_IMAGE_ADMIN_NAME,
                                imageTag: env.DOCKER_IMAGE_TAG,
                                credentails: 'DockerHubCreds'
                            )
                        }
                    }
                }
                
            }
        }
    }
    post {
        success {
            emailext(
                subject: "SUCCESS: ${env.JOB_NAME} Build #${env.BUILD_NUMBER}",
                body: """
                Good news!

                Build completed successfully.

                Job Name: ${env.JOB_NAME}
                Build Number: ${env.BUILD_NUMBER}
                Branch: ${env.GIT_BRANCH}

                Build URL:
                ${env.BUILD_URL}

                Regards,
                Jenkins CI
                """,
                to: "sghasal5@gmail.com"
            )
        }

        failure {
            emailext(
                subject: "FAILED: ${env.JOB_NAME} Build #${env.BUILD_NUMBER}",
                body: """
                Attention Required!

                Build has failed.

                Job Name: ${env.JOB_NAME}
                Build Number: ${env.BUILD_NUMBER}
                Branch: ${env.GIT_BRANCH}

                Console Output:
                ${env.BUILD_URL}console

                Please check logs and fix the issue.

                Regards,
                Jenkins CI
                """,
                to: "sghasal5@gmail.com"
            )
        }
    }
}
