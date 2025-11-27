pipeline {

  agent { dockerfile true }

  parameters {
        gitParameter branchFilter: 'origin/(.*)', defaultValue: '2025.02.x', selectedValue: 'DEFAULT', name: 'BRANCH', type: 'PT_BRANCH', description: 'branch to build'
        choice choices: ['stm32mp157f_dk2_defconfig', 'qemux86-64_defconfig'], description: 'select config', name: 'CONFIG'
        choice choices: ['no', 'yes'], description: 'clean workspace', name: 'CLEAN'
    }

    stages {

        stage('Clean') {
            when {
                expression { params.CLEAN == 'yes' }
            }
            steps {
                sh '''
                    make clean
                '''
            }
        }

        stage('Configure') {
            steps {
                sh "make ${params.CONFIG}"

            }
        }

        stage('Build Image') {
            steps {
                sh "make"
                archiveArtifacts artifacts: "output/images/*rootfs* , \
                                             output/images/*.img.*",
                                            followSymlinks: true,
                                            fingerprint: true,
                                            onlyIfSuccessful: true

            }
        }

        stage('Generate SDK') {
            steps {
                sh "make sdk"
                archiveArtifacts artifacts: "output/images/*-buildroot-linux-gnu_sdk-buildroot.tar.gz",
                                            followSymlinks: true,
                                            fingerprint: true,
                                            onlyIfSuccessful: true

            }
        }
    }
}