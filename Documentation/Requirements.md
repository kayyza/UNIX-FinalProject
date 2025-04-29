# Requirements

## <br>Basic system setup and security: 

## Accounts Creation:
Create a sudo user for deployment purposes that is not root. This user will be able to pull from the Git repository and manage web files.

## Authentication Method:
Generate SSH key authentication for the user on the local machine, then copy the public key to the server.

## File Permissions:
Only the user we created should be able to update the web directory and the server should be able to read the web directory. 

## Firewall Configuration: 
Only allow ports that we will be using, for example port 22 for SSH access and then port 80 for the website. 
