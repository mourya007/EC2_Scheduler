This Task automating the start and stop of Amazon EC2 instances based on a specified schedule using AWS CloudWatch Events, AWS Lambda functions, and Terraform. The goal is to reduce costs by ensuring instances are only running when needed, specifically during weekdays.

Overview
The solution involves:
- AWS CloudWatch Events: To trigger actions based on a cron schedule.
- AWS Lambda Functions: To start and stop EC2 instances.
- IAM Roles and Policies: To securely grant the necessary permissions to the Lambda functions.
- Terraform: To define and deploy the infrastructure as code.

Requirements
AWS Account
Terraform v1.0 or higher
AWS Services:  Lambda, EC2, CloudWatch, IAM.
TAG: Must have tag assigned  ``` AutoStartStop = True```

Implementation Steps
1. Define Variables
Variables allow for the customization of the instance start/stop schedule and the tagging strategy used to identify which instances to control.

2. Create IAM Role and Policy
A role for the Lambda function with a policy granting minimal permissions needed to start and stop instances.

3. Lambda Functions
You need two Lambda functions: one to start instances and another to stop them. The functions should filter instances by the specified tags and change their state accordingly.

4. CloudWatch Event Rules and Targets
Define CloudWatch Event Rules to trigger the Lambda functions according to the schedule.
5. Lambda Permissions
Grant CloudWatch Events permission to invoke the Lambda functions.

Deployment Steps
1. Prepare Lambda Functions: Write the code for the start and stop Lambda functions. 
2. Terraform Initialization: Run terraform init in your project directory to initialize Terraform and download the necessary providers.
3. Terraform Plan: Execute terraform plan to review the actions Terraform will perform before making any changes to your infrastructure.
4. Terraform Apply: Run terraform apply to apply the configuration and create the resources in your AWS account. Confirm the action when prompted.
5. Verification: After deployment, verify that the CloudWatch Event Rules trigger the Lambda functions at the specified times and that the EC2 instances start and stop as expected.


