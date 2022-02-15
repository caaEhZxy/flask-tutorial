pipeline {
    agent any
    environment {
        IMAGE_NAME = 'pass.nutsb.com/flask-tutorial'
    }
    stages {
        stage('Build image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${GIT_COMMIT[0..6]} ."
                sh "docker tag ${IMAGE_NAME}:${GIT_COMMIT[0..6]} ${IMAGE_NAME}:latest"
            }
        }
        stage('Push image') {
            steps {
                withDockerRegistry([ credentialsId: "docker", url: "https://pass.nutsb.com/v1" ]) {
                    sh "docker push ${IMAGE_NAME}:${GIT_COMMIT[0..6]}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
        stage('Deploy') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'develop', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '/usr/local/bin/docker-compose --project-directory /data/dockerfile/flask-tutorial up -d', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/data/dockerfile/flask-tutorial/', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**/docker-compose.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}
