#!/bin/bash
#application to mirror the website / run the container

RED='\033[1;91m'
ORANGE='\033[0;33m]'
GREEN='\033[1;32m'
NC='\033[0m'

user_name=$(whoami) #checks who is the current user and puts in a variable
user_os=$(uname -s)
username=""

echo "Hi $user_name!"
echo "You seem to want to host your own website! Let's get started!"
echo ""
echo "Menu___________________________"
echo "1. Automatic setup"
echo "2. Advanced setup"
read -p "->  " setupChoice

if [ $setupChoice = 2] then 
    read -p "Create ssh ? (y/N)" userAns
    if [[ "${userAns}" == "Y" || "${userAns}" == "y" ]]; then
        echo "SSH creation..."
        read -p "Deploying unsername : " $username
        bash ./2_set_ssh.sh "$username"
        echo -e "${GREEN} ssh configured successfully ! ${NC} "
    else 
        echo "No SSH created"
    fi
    ;;

    read -p "Configure firewall ? (y/N)" userAns1
    if [[ "${userAns1}" == "Y" || "${userAns1}" == "y" ]]; then
        echo -e "Log file : /var/log/firewall_setup.log"
        bash ./3_config_firewall.sh
    else 
        echo "No firewall configured : all ports are open and available"
    fi
    ;;

    read -p "Configure permissions ? (y/N)" userAns2
    if [[ "${userAns2}" == "Y" || "${userAns2}" == "y" ]]; then
        echo -e "Web directory : /var/www/html"
        bash ./4_set_perms.sh "$username"
    else 
        echo "No permission configured"
    fi
    ;;

    read -p "Setup webhook listener ? (y/N)" userAns3
    if [[ "${userAns3}" == "Y" || "${userAns3}" == "y" ]]; then
        echo -e "Web directory : /var/www/html"
        bash ./7_setup_webhook_listener.sh
    else 
        echo "No webhook listener configured"
    fi
    ;;

    echo "Checking if docker is installed..."
    bash ./11_dockerInstaller.sh

else
    echo "Creating ssh for <deployuser>..."
    echo "."
    echo "."
    bash ./2_set_ssh.sh "deployuser"
    echo -e "${GREEN} ssh configured successfully ! ${NC} "
    
    echo "Configuring firewall..."
    echo "."
    echo "."
    bash ./3_config_firewall.sh
    echo -e "${GREEN} firewall configured successfully ! ${NC} "

    echo "Configuring permissions as <deployuser>..."
    echo "."
    echo "."
    bash ./4_set_perms.sh "deployuser"
    echo -e "${GREEN} firewall configured successfully ! ${NC} "

    echo "Creating webhook listener..."    
    echo "."
    echo "."
    bash ./7_setup_webhook_listener.sh
    
    echo "Checking if docker is installed..."
    bash ./11_dockerInstaller.sh
fi

read -p "Press A to use the advanced setup or enter to continue to default setup" user_ans

if [[ "${user_ans}" == "A" || "${user_ans}" == "a" ]]; then
    read -p "Choose the repo directory or the direct directory : " REPO_DIR
    echo $REPO_DIR
    
    read -p "Input the folder in which the website will be held (i.e. src) : " TEMP_SITE_DIR #not sure about this
    echo $TEMP_SITE_DIR
    
    read -p "input the URL of the website to mirror : " MIRROR_URL
    echo $MIRROR_URL
    
    SITE_DIR="${REPO_DIR%/}/${TEMP_SITE_DIR#/}"
    
    read -p "Input the website name please : " WEBSITE_NAME
    echo $WEBSITE_NAME
    
    echo "Define running port of the website"
    echo -e "${ORANGE} ⚠️If the firewal has been setup beforehand, only port 22 and 80 are open⚠️ ${NC}"
    read -p "suggested : port 80, 22, or 3000 if there was no firewall setup : " PORT
    echo $PORT

else
    REPO_DIR="/home/deployuser/UNIX-FinalProject"
    SITE_DIR="${REPO_DIR%/}/hosted_website"
    PORT="80"
    
    read -p "input the URL of the website to mirror : " MIRROR_URL
    echo $MIRROR_URL
    
    read -p "Input the website name please : " WEBSITE_NAME
    echo $WEBSITE_NAME
fi

echo "${GREEN} Setup completed !"
echo "${GREEN} -> Using:"
echo "${GREEN}    REPO_DIR    = ${REPO_DIR}"
echo "${GREEN}    SITE_DIR    = ${SITE_DIR}"
echo "${GREEN}    MIRROR_URL  = ${MIRROR_URL}"
echo "${GREEN}    WEBSITE_NAME= ${WEBSITE_NAME}"
echo "${GREEN}    PORT        = ${PORT}"
echo "${NC}"

#ensuring everything is there and working... -> doing this later ..?
#rm -rf "${SITE_DIR}"
#mkdir -p "${SITE_DIR}"

echo "Menu___________________________"
echo "1 . Mirror a static github page website"
echo "2 . Host a node-based webiste"
read -p "-> " user_ans

if [ $user_ans = 1 ]; then
    echo "Creating dockerfile..."

    cat > "${SITE_DIR}/Dockerfile" <<'EOF'
            FROM nginx:alpine
            RUN rm -rf /usr/share/nginx/html/* # Remove default welcome page
            COPY . /usr/share/nginx/html # Copy all static files into nginx’s html dir
            EXPOSE $PORT
            CMD ["nginx", "-g", "daemon off;"]
            EOF

    echo "$dockerfile_content" > "$SITE_DIR/Dockerfile"
    bash ./6_deploy.sh "$REPO_DIR" "$SITE_DIR" "$MIRROR_URL" "$WEBSITE_NAME" "$PORT"

elif [ $user_ans = 2 ]; then
    echo "Creating dockerfile..."

    cat > "${SITE_DIR}/Dockerfile" <<'EOF'
            FROM node:24-alpine3.20
            WORKDIR /app/
            COPY src/ /app/
            RUN npm install
            EXPOSE $PORT
            CMD [ "node", "app.js" ]
            EOF

    echo "$dockerfile_content" > "$SITE_DIR/Dockerfile"
    #bash ./6_deploy.sh "$REPO_DIR" "$SITE_DIR" "$MIRROR_URL" "$WEBSITE_NAME" "$PORT"
else
    echo -e "${RED} [❗ERROR❗] invalid answer... Exiting hosting wizard :( ${NC}";
    exit 1;
fi

if [[ $setupChoice = 2 && $user_ans = 1 ]] then 
    read -p "please enter your email : " EMAIL
    bash '.5_ssl_setup.sh' "$MIRROR_URL" "$EMAIL"
elif [ $setupChoice = 2 ] then
    read -p "Create backup ? (y/N)" userAns3
    
    if [[ "${userAns3}" == "Y" || "${userAns3}" == "y" ]]; then
        bash "./8_backup.sh"
    else 
        echo "No backup made"
    fi
    ;;

    read -p "Create cron ? (y/N)" userAns4
    if [[ "${userAns4}" == "Y" || "${userAns4}" == "y" ]]; then
        bash "./9_cron.sh"
        echo "cron file : /etc/cron.d/project_maintenance"
        echo "SSL certificate renewal should run daily at 2:30am"
    else 
        echo "No cron made"
    fi
    ;;

else 
    bash "./8_backup.sh"
    bash "./9_cron.sh"
fi
;;

echo -e "${GREEN} setup finished ! "
echo -e "${GREEN} Wizard will exit in 5 ! ${NC} "
sleep 5
exit 0;
