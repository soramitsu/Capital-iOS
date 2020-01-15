node('mac-ios-1') {
    properties(
	    [
		    disableConcurrentBuilds()
		]
    )
    withCredentials([
        [$class: 'UsernamePasswordMultiBinding', credentialsId: 'password_on_mac_ios_1', usernameVariable: 'FL_UNLOCK_KEYCHAIN_USER', passwordVariable: 'FL_UNLOCK_KEYCHAIN_PASSWORD'],
        [$class: 'UsernamePasswordMultiBinding', credentialsId: 'apple_developer_user', usernameVariable: 'FASTLANE_USER', passwordVariable: 'FASTLANE_PASSWORD'],
        [$class: 'UsernamePasswordMultiBinding', credentialsId: 'api_token_for_crashlytics', usernameVariable: 'CRASHLYTICS_API_TOKEN', passwordVariable: 'CRASHLYTICS_BUILD_SECRET'],
        [$class: 'UsernamePasswordMultiBinding', credentialsId: 'sorabot-github-user', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD']])
    {
        timestamps {
            try {
                stage('Git pull'){
                    def scmVars = checkout scm
                    env.GIT_BRANCH = scmVars.GIT_BRANCH
                    env.GIT_COMMIT = scmVars.GIT_COMMIT
                    sh 'git config --global credential.helper "/bin/bash ' + env.WORKSPACE + '/credential-helper.sh"'
                    env.FASTLANE_DISABLE_COLORS = '1'
                    env.LC_ALL = 'en_US.UTF-8'
                    env.LANG = 'en_US.UTF-8'
                }
                stage('Add cocoapods repo') {
                    sh 'pod repo remove soramitsu || true'
                    sh 'pod repo add soramitsu https://github.com/soramitsu/podspec-ios.git master || true'
                }
                stage('Test library') {
                    sh 'pod lib lint --sources=soramitsu,master --verbose'
                }
                if (env.TAG_NAME) {
                    stage('Push library to podspec-ios') {
                        sh 'pod repo push --verbose soramitsu CommonWallet.podspec'
                    }
                }
                if (!env.TAG_NAME) {
                    stage('Update cocoapods') {
                        dir("Example") {
                            sh 'fastlane update_cocoapods'
                        }
                    }
                    stage('Set environment variables for app') {
                        env.CI_FASTLANE_APP_ID = 'co.jp.soramitsu.capital'
                        env.CI_FASTLANE_TEAM_ID = 'YLWWUD25VZ'
                        env.CI_FASTLANE_ADHOC_ENABLE = 'true'
                        env.CI_FASTLANE_EXP_METHOD = 'ad-hoc'
                        env.CI_FASTLANE_PROVISIONING_PROFILE = 'capital-adhoc'
                        env.CI_FASTLANE_CODE_SIGN_ID = 'iPhone Distribution: SORAMITSU K.K. (YLWWUD25VZ)'
                        env.CI_FASTLANE_FABRIC_GROUP = 'capital-test'
                        env.CI_FASTLANE_BUILD_ID = env.BUILD_ID
                    }
                    stage('Test app') {
                        dir("Example") {
                            sh 'fastlane tests'
                        }
                    }
                    stage('Build app') {
                        dir("Example") {
                            sh 'fastlane build'
                        }
                    }
                    stage('Deploy app') {
                        dir("Example") {
                            if (env.GIT_BRANCH == 'master') {
                                sh 'fastlane deploy_on_fabric'
                            } else {
                                println "Deploy skipped"
                            }
                        }
                    }
                }
            } catch (e) {
                currentBuild.result = 'FAILURE'
            } finally {
                junit allowEmptyResults: true, keepLongStdio: true, testResults: 'fastlane/test_output/report.junit'
                sh 'git config --global --unset credential.helper || true'
                cleanWs()
            }
        }
    }
}