#!/bin/bash

#REPO_DIR="/home/deployuser/UNIX-FinalProject"
#SITE_DIR="$REPO_DIR/[insert site here]"
#MIRROR_URL="https://sr-delightfully.github.io/portfolio-2023/"
#LOG_FILE="/var/log/deploy.log"

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
    read -p "Define running port of the website (suggested : port 80) : " PORT

else
    REPO_DIR="/home/deployuser/UNIX-FinalProject"
    SITE_DIR="${REPO_DIR%/}/hosted_website"
    read -p "input the URL of the website to mirror : " MIRROR_URL
    echo $MIRROR_URL
    read -p "Input the website name please : " WEBSITE_NAME
    echo $WEBSITE_NAME
    PORT="80"
fi

echo
echo "-> Using:"
echo "   REPO_DIR    = ${REPO_DIR}"
echo "   SITE_DIR    = ${SITE_DIR}"
echo "   MIRROR_URL  = ${MIRROR_URL}"
echo "   WEBSITE_NAME= ${WEBSITE_NAME}"
echo "   PORT        = ${PORT}"
echo

#ensuring everything is there and working... -> doing this later ..?
#rm -rf "${SITE_DIR}"
#mkdir -p "${SITE_DIR}"


echo "Creating dockerfile..."

cat > "${SITE_DIR}/Dockerfile" <<'EOF'
        FROM nginx:alpine
        RUN rm -rf /usr/share/nginx/html/* # Remove default welcome page
        COPY . /usr/share/nginx/html # Copy all static files into nginx’s html dir
        EXPOSE 80
        CMD ["nginx", "-g", "daemon off;"]
        EOF

echo "$dockerfile_content" > "$SITE_DIR/Dockerfile"
bash ./6_deploy.sh "$REPO_DIR" "$SITE_DIR" "$MIRROR_URL" "$WEBSITE_NAME" "$PORT"
