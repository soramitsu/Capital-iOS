@Library('jenkins-library@feature/ios-pipeline' ) _

//def libPipline = new org.ios.LibPipeline(steps: this)
//libPipline.runPipeline()

def appPipline = new org.ios.AppPipeline(steps: this, appRootDir: 'Example', tagDeployment: false)
appPipline.runPipeline('capital')

