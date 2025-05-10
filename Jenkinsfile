// Checking if PR is updated for code commit and if Jenkins build is triggered
pipeline {
    agent {
        node {
            // Use the default node or specify a label if needed, e.g., 'java'
            label 'java' 
        }
    }

    environment {
        // Define any custom environment variables if needed
        JAVA_HOME = '/usr/lib/jvm/java-11-openjdk'
        MAVEN_HOME = '/usr/share/maven'
    }

    stages {
        stage('Print Environment Variables') {
            steps {
                echo 'Printing all environment variables:'
                sh 'printenv'  // On Unix/Linux systems
                // For Windows, use: bat 'set'
            }
        }

        stage('Checkout Code') {
            steps {
                echo 'Checking out the code...'
                checkout scm  // Checks out the repository from the configured SCM
            }
        }
        /*  
        stage('Build') {
            steps {
                echo 'Building the project...'
                sh '''
                ${MAVEN_HOME}/bin/mvn clean install
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh '''
                ${MAVEN_HOME}/bin/mvn test
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Add deployment steps here if needed
            }
        }
        */
    }

    post {
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
