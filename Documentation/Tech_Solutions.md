# Tech Solutions

    In this document, we'll be discussing the various parts that compose our technology stack. This includes a description of the technology, it's purpose, and why we chose this technology over the other options. 

## Infrastructure:

### Containerization:
    To handle the containerization of our application for our project, we have decided to use Docker. 
     
    Why use Docker?
    - Docker simplifies deployment and testing.
    - Docker ensures that there is consistency between the local environment and the server environment.
    - Docker facilitates the dependencies management process as well as versioning.
    - Docker has a large community and plenty of detailed documentation for us to reference. 

### Hosting:
    To handle hosting, we decided on the VPS DigitalOcean.
    After thorough research and comparisons on the various platfoms that make hosting possible we came to a decision based on technical factors as well as practicality. 
    The platform we chose supports a fully configurable GNU/Linux web server, allows root acces and allows us to have full control over system-level operations.

    While the platform AWS EC2 outperformed DigitalOcean in the comparisions due to its technical features and scalability, we chose DigitalOcean as it has a more beginner-friendly interface, extensive documentation and we were already familiar with navigating this website.
    Google Cloud was another possible option that meets all of the requirements that we would need for this project. However, its pricing model was not as predicatable and may not be feasable for our project's intentions. 

    DigitalOcean allows us to fully configure our Ubuntu-based VPS. It is compatible with docker, and provides SSH access with key-based authentications. DigitalOcean provides flexibility that will allow us to set up scheduled tasks, security rules and custom services. 

    Should any issues occur, we will keep AWS EC2 as a backup solution. 

### Handling backup:
    Backups will be handled via automated cron jobs. It will do so by archiving our application/web directory. The jobs will be run on the host system and can be recovered in the event of a system failure. 
        Backup files are stored locally for now, and can be pushed to DigitalOcean's spaces (object storage) later on. 


## Backend:

### Server:
    for this project, we will create a self-managed Ubuntu VPS on DigitalOcean. This setup allows Docker containers to server the website content directly while also simplifying the configuration and avoiding the need for a separate reverse proxy. 

    Our website will consist of static files and webhook listeners that are deployed inside of the Docker containers. The Ubuntu server should be configured to allow secureSSH access with key authentication, restrict access with a configured firewall, run scheduled tasks with cron and automatically pull and deploy changes from GitHub using a webhook listener container.
    # Database:
    Since our project has a focus on the deployment process, we decided to not include any databases. Instead, we will server static user-uploaded pages (frontend only).
    Though if we were to continue this project later on, the set up we currently have will allow for the addition of a database container composed of either PostgreSQL or MySQL through the Docker Compose. This would allow for dynamic content or even user data storage to become a necessity. 
    # APIs:
    We will be using `Webhook listener`, an API that listend for GitHub push evevnts and executes `git pull` inside of the Docker container to deploy the updated static pages. 

## Service Management:
### Systemmd Service for Webhook Listener:
The webhook Listener script will be deployed as a Docker container, and will restart automatically using the Docker's restart policy. 
`--restart=always`

Cron Job will be used for scheduled tasks such as the backup and maintenance scripts. These tasks may be containerized in the future if necessary.

Automated backup will be set up through a backup script that will run on a schedule and archive the website directly inside of the Docker's volume. The script can be enhanced to upload backups to DigitalOcean spaces.

### Deployment strategy"

  Through the use of GitHub Webhook, we will trigger auto-deployment. Whenever new code is pushed to the main branch, the Webhook listener should recieve the event and trigger a `git pull` inside of said container volume. This should ensuer that the live website will be updated automatically with minimal manual intervention.  