@Library('jenkins-library@feature/ios-pipeline' ) _

def libPipline = new org.ios.LibPipeline(steps: this)
def appPipline = new org.ios.AppPipeline(steps: this, appRootDir: 'Example', tagDeployment: false)

libPipline.runPipeline()
appPipline.runPipeline('capital')

