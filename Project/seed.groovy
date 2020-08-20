base_path = "Learnings"
job_path = "${base_path}/Project"
folder("${base_path}")
pipelineJob(job_path) {
    description("This job creates new pipeline")
    logRotator {
        daysToKeep(30)
    }
    
    definition {
        cps {
            script(readFileFromWorkspace("${job_path}/Jenkinsfile"))
            sandbox(false)
        }
    }
}
