## AWS Deployment

The Journal API was deployed to AWS as a two-tier application with a public application tier and a private database tier.

### Architecture

```text
                                  Internet
                                     │
                         HTTPS :443 / HTTP :80
                                     │
                                     ▼
                              ┌─────────────┐
                              │    Nginx    │
                              │ Reverse     │
                              │ Proxy + TLS │
                              └──────┬──────┘
                                     │
                              127.0.0.1:8000
                                     │
                                     ▼
                              ┌─────────────┐
                              │  FastAPI    │
                              │  Journal    │
                              │    API      │
                              └──────┬──────┘
                                     │
                         ┌───────────┴───────────┐
                         │                       │
                         ▼                       ▼
                  ┌─────────────┐        ┌─────────────┐
                  │ PostgreSQL  │        │   Amazon    │
                  │    RDS      │        │  Bedrock    │
                  │ Private Tier│        │ AI Analysis │
                  └─────────────┘        └─────────────┘
                         ▲
                         │
                  TCP 5432 only
                  from EC2 SG
                         │

Administrative traffic
        │
        │ AWS Systems Manager
        │ Session Manager
        ▼
   ┌─────────────┐
   │    EC2      │
   │ Application │
   │    Tier     │
   └─────────────┘
```

### AWS Services

The deployment uses:

- **Amazon VPC** — network isolation with public and private subnets.
- **Amazon EC2** — hosts the Journal API and Nginx reverse proxy.
- **Amazon RDS for PostgreSQL** — private database tier.
- **AWS Systems Manager Session Manager** — authenticated administrative access without exposing SSH.
- **AWS IAM** — EC2 instance role used for AWS service access.
- **Amazon Bedrock** — live AI analysis of journal entries.
- **Nginx** — reverse proxy and HTTPS termination.
- **Let's Encrypt / Certbot** — trusted TLS certificate.
- **AWS Budgets** — cost monitoring and budget alerting.

### Access Controls

- The EC2 instance is publicly reachable only through HTTP/HTTPS.
- FastAPI listens locally on `127.0.0.1:8000` and is not exposed directly to the internet.
- Nginx handles public HTTP/HTTPS traffic and proxies requests to FastAPI.
- HTTP traffic is redirected to HTTPS.
- PostgreSQL is deployed in the private tier.
- The RDS security group permits PostgreSQL traffic on port `5432` only from the application-tier security group.
- SSH is not exposed publicly; administrative access is performed through AWS Systems Manager Session Manager.
- The EC2 instance uses an IAM instance role for AWS API access rather than storing AWS credentials on the server.
- Application credentials and secrets are kept outside source control.

### AI and Safety Controls

The Journal API performs live journal analysis using **Amazon Bedrock** with the `openai.gpt-oss-20b-1:0` model.

The deployment uses:

- IAM-based authentication from the EC2 instance role.
- An Amazon Bedrock Guardrail applied to analysis requests.
- Structured JSON output validation before returning analysis results.
- No API credentials stored in the application source code.

The application does not provide user authentication or data isolation. Only test data should therefore be used with this deployment.

### Expected Cost

The expected AWS cost for this deployment was estimated before provisioning and an AWS Budget alert was configured to monitor spending.

### Expected Cost

The deployment was estimated at approximately **$1.50 USD per day** when running continuously (24/7), corresponding to roughly **$45 USD per month**.

This is an estimate rather than an exact monthly bill. The majority of the expected cost comes from the **Amazon RDS PostgreSQL instance**. Actual costs will vary depending on resource usage and Amazon Bedrock inference.

An AWS Budget alert was configured to monitor spending.

The actual cost depends on resource usage, particularly EC2, RDS, and Amazon Bedrock inference.

### Deployment Constraint Evidence

| Requirement                                           | Evidence                                                                                                                                                                           |
| ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Public HTTPS with a trusted certificate               | Journal API is accessible through Nginx using HTTPS with a trusted Let's Encrypt certificate. HTTP requests are redirected to HTTPS.                                               |
| PostgreSQL on a separate private tier                 | PostgreSQL runs on Amazon RDS in private subnets. Its security group only permits port `5432` from the application-tier security group.                                            |
| Private management access and protected credentials   | EC2 administration is performed through AWS Systems Manager Session Manager. No public SSH access is required. AWS access uses an EC2 IAM role rather than stored AWS credentials. |
| Service survives administrative sessions and restarts | The Journal API runs as a systemd service and continues running after the administrative session ends and after an EC2 reboot.                                                     |
| CRUD and live AI analysis preserved                   | CRUD operations were tested against the deployed API, and journal analysis successfully called Amazon Bedrock and returned sentiment, summary, and topics.                         |
| Cost monitoring configured before provisioning        | An AWS Budget alert was configured for the deployment.                                                                                                                             |

### Production Limitation

The main limitation before using this system in production is **the lack of user authentication and data isolation**.

The Journal API currently does not distinguish between users or restrict access to individual users' journal entries. A production version would therefore need an authentication and authorization system, together with appropriate per-user data isolation, before handling real or sensitive journal content.
