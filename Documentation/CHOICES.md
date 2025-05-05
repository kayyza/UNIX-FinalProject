# CHOICES.md

## VPS Provider
**Choice:** DigitalOcean \
\
**Reason:** Chosen for ease of use, low cost, quick provisioning, simple documentation and easy support for SSH key authentication and Linux droplets.\

## Operating System
**Choice:** Ubuntu 22.04 LTS \
\
**Reason:** Most popular choice, stable, widely supported, and familiar for system admins administrator tasks

## SSH Authentication
**Choice:** SSH key-based authentication \
\
**Reason:** More secure than password-based login and easier to manage for multiple users. Ensures secure, encrypted access to the server.

## User Management
**Choice:** Created a non-root user `deploy` with sudo privileges \
\
**Reason:** This user is used for managing deployments without granting root access. This decision enhances server security.

## File Permissions
**Choice:** Configured `.ssh` directory and key file permissions for the `deploy` user  \
\
**Reason:** Ensures proper security for SSH login and restricts unauthorized access to SSH credentials.

## Team Collaboration
**Choice:** Shared SSH public keys will be added to `deploy` user;s `authorized_keys` \
\
**Reason:** Allows all team mmebers secure access without sharing passwords
