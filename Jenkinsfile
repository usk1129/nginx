pipeline {
  agent any
  parameters {
    choice(
        name: 'Action',
        choices: "apply\ndestroy",
        description: 'Apply or Destroy the instance' )
  }
  stages {

    stage('Checkout') {
        steps {
            git branch: 'main', credentialsId: 'github', url: 'https://github.com/usk1129/nginx'
        }
    }

    stage('Terraform') {
      steps {
        script {
          if (params.Action == "apply") {
            sh 'terraform init terraform/static-site'
            sh 'terraform apply -var="name=app" -var="group=web" -var="region=us-east-1" -var "profile=default" --auto-approve terraform/static-site'
          } 
          else {
            sh 'terraform destroy -var="name=app" -var="group=web" -var="region=us-east-1" -var "profile=default"  --auto-approve terraform/static-site'
          }
        }
      }
    }
    stage('Ansible deploy'){
    steps{
        ansiblePlaybook credentialsId: 'private-key',
                        disableHostKeyChecking: true, 
                        playbook: 'ansible/static-site/site.yml',
                        inventory: 'ansible/static-site/hosts'
    }
}
  }
}