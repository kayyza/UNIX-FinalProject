Journal belongs to: Sabrina Robinson
# Journal entry #1:

**Date**: 2025-04-28<br>
<b>Time spend</b>: ≈ 3 hours<br>
<b>Time spent Working on</b>:<br><br>
    <i>Most of my time was spent on the Major Technical Solutions. My task was to find possible platforms that we could use to fulfill our project's requirements, and compare those platforms to find the best solution for our situation.</i> <br>

    I gathered a list of platforms with the help of chatGPT, and a few additional ones that I had already been aware of such as Digital Ocean, Google Cloud and Heroku. 

    From there, I compiled a table with the various qualities that our ideal platform should provide. Of course, none of the platforms met all of our requirements so we compared the pros and cons of each.

    We knew from the start that Heroku and Netlify would be unlikely solutions as they had limited to no cnotrol and did not allow us to have root access. This being an important aspect of our project meant they could no longer be options.

    So that left us to compare the remainding platforms; Digital Ocean, AWS Ec2, and Google Cloud. All of which provide VPS Setup, Root Access control, and have fully configurable webservers. We knew that we were likely unlikely to choode Google cloud as the pricing can get out of hand rather quickly. So we delved deeper into the differences between Digital Ocean and AWS Ec2. 

<b>While AWS ec2 did out-perform Digital Ocean for the attributes we were looking for, we ultimately decided to go with Digital Ocean as our platform of choice as it was a website that we already knew how to navigate and knew had plenty of well documented tutorials and articles about how to set things up.</b> 

    With this decision, if we run into any issues, AWS Ec2 would be our backup solution. However, we dont foresee this being a necessary step in the projects development as of this date. <br><br>

    Asides from that, I helped with writting infomation for the project proposal as well as organized and created files for future documentation. (including this document as well :D )

    Unfortunately, I have other projects to work on and exams to perpare for so I didn't have additional work to offer. Though I plan to make up for that in time for the next journal entry, the next step is setting up and testing!

# Journal entry #2:

**Date**: 2025-05-05<br>
<b>Time spend</b>: ≈ 3 hours<br>
<b>Time spent Working on</b>:<br><br>

Preparing Batch files: 
    Starting with the configuration of the firewall. 
    Learning how to use the UWF (uncomplicated firewall) with a focus on learning how to disable all external connections except over port 22, tcp protocol 

    `apt install ufw`
    `ufw default deny incoming`
    `ufw defaul allow outgoing`
    `ufw status `
    
to check if firewall has been activated
you can into external system at this point. 

    `ufw enable`
if you try to login from the ssh on the external system while the firewall is active the connection 

in the internal machine's terminal you can run this command to create a "hole" in the firewall. `ufw allow ssh` and/or `ufw allow 22`. Meaning that this is a known external connection and is allowed through the wall.

if you attempt to login to the ssh now, it should ask you for a password.
if one day you might want to remove this rule, you can do so with `ufw delete allow ssh`

To block all ssh connections except for a specific ip address, you can use `ufw allow from [insert ip address here] to any port 22`

I started to set up the actual files that we will need to compile in order to facilitate the reproduction of this project, 
though its gettings late and i sense that I'm going to pass out at any moment.. so i will finish this tomoorw..