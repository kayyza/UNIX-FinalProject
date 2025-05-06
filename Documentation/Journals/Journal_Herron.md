Journal belongs to: Rachel Herron 
# Journal entry #1:
Link to repository: https://github.com/kayyza/UNIX-FinalProject \
Thursday April 24th, 2025 
 
Worked on Project Team Proposal – Approximate Hours Spent: 3 hours 

- Researched possible VPS services we could use 
- Looked over class notes to see what recommendations for possible VPS services we use 
    - Asked ChatGPT for its recommendation based on the concept of the project 
        -	Asked about cheapest option 
        -	Asked about easiest option 
        -	Asked to compare to other options to see the di	erence between the choices 
        
    - Searched Google to see what recommendations and options were available 
        -	Compared the answer from ChatGPT to the “Google AI Overview”  Visited a couple of websites discussing options 
 
-	https://www.digitalocean.com/ 
 
-	https://cyberpanel.net/blog/digitaloceandroplets#:~:text=Users%20can%20deploy%20DigitalOcean% 20Droplets%20with%20various,application%20images%20av ailable%20in%20the%20DigitalOcean%20Marketplace. 
 
 
-	https://flywp.com/blog/5387/digitalocean-vsaws/#:~:text=Simple%20and%20user%2Dfriendly:%20Digital Ocean%20is%20known%20for,beginners%20or%20those%20 new%20to%20cloud%20computing. 
 
I decided about the best choice after consulting all these resources and discussing with my teammates about their opinions. After the discussion and research, we’d decided on Digital Ocean being the best option for us.  
- Made a basic guideline for the requirements o Looked over class notes on this topic to get a general idea of the steps needed to take for our concept 
    - Asked ChatGPT for a guideline based on our requirements 
        -	Asked about basic system setup and security 
        -	Process/service management 
        -	Automated tasks o Searched Google similarly to how I did in the previous step (Comparing with 
ChatGPT and various websites) 
    -	https://blog.cloudsigma.com/how-to-configure-automaticdeployment-with-git-with-a-vps/ 
    -	https://www.digitalocean.com/community/tutorials/how-to-set-upautomatic-deployment-with-git-with-a-vps 
    
I did not go into a lot of detail about the requirements, more so just a skeleton of what needs to be done. After reviewing the guidelines with teacher, I realized that more options and details should have been considered in the requirements for the Project Proposal. I also realized that the timeline at the end of the document needs to be fixed. I also came to realize that we need to make an INSTALL file and README file.  

# Journal entry #2

Link to repository: https://github.com/kayyza/UNIX-FinalProject \
Thursday May 1st , 2025  \
Monday May 5th, 2025

Worked on setting up the DigitalOcean VPS  | Approximate Hours Spent: 5-6 hours

* Created a DigitalOcean Droplet
    * Generated SSH key pair on local machine
    * Added public key to the Droplet using the DigitalOcean Dashboard 
    * Verified SSH connectivity as root user
      
* Created non-root user for safer security
    * Granted “deploy” user sudo privileges 
    * Set up SSH login for “deploy”, verified permissions and tested successful login
    * Ensured correct file and directory permissions for more secure access
      
* Documentation
    * Updated INSTALL.md file in the repository with a step-by-step guide of what I’ve accomplished thus far
    * Updated CHOICES.md file in the repository based on the work I’ve completed thus far

Last week, I was stuck on getting the SSH connectivity from my local machine to the DigitalOcean Droplet to work for a long time. I feel that I spent too much time on trying to correct this issue, because once I got the SSH connection working, the following steps did not take me much time. 
I kept getting an error message that said, “Connection Refused”, which I found weird because everything seemed to be set up properly with the Droplet. The issue had to do with the school Wi-Fi network in the end. I ended up connecting my personal hotspot from my phone and the SSH connection worked perfectly. 
For all the work that I’ve done, my resources that I used were mostly class notes/labs and ChatGPT. I mostly used ChatGPT to help me troubleshoot my issues. The class notes/labs I used as guidance for the steps I took in my process. 

