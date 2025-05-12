#!/bin/bash
#application to mirror the website / run the container

user_name=$(whoami) #checks who is the current user and puts in a variable
user_os=$(uname -s)

echo "Hi $user_name!"
echo "You seem to want to host your own website! Let's get started!"

# Check if Docker is installed ---
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Attempting to install Docker..."

    # Detect OS
    case "$user_os" in
      Linux)
        echo "Detected Linux"
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        rm get-docker.sh
        ;;

      Darwin)
        echo "Detected macOS, trying to install through Homebrew..."
        if {
            command -v brew &> /dev/null; then
            #echo "Installing Docker via Homebrew..."
            brew install --cask docker
        } || {
            echo "Homebrew not working or not installed. Trying to install through terminal..."
            curl -fsSL "$DMG_URL" -o "$DMG_PATH" #grabs the Docker installation from the website
            sudo hdiutil attach "$DMG_PATH" #mounts the installation
            sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license #runs the installation and automatically accepts the license
            sudo hdiutil detach /Volumes/Docker
            rm -f "$DMG_PATH" # recursive cleanup
        }
        else
          echo "[❗ERROR❗] unable to automatically install Docker -> please install Docker Desktop manually from https://www.docker.com/products/docker-desktop/"
          exit 1
        fi
        ;;

      CYGWIN*|MINGW*|MSYS*)
        echo "Detected Windows-like environment"
        {
            # Enable the WSL 2 feature on Windows
            wsl --install --no-distribution
            # Download the Docker Desktop installer
            $INSTALLER="DockerDesktopInstaller.exe"
            Invoke-WebRequest `
                -Uri https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe `
                -OutFile $INSTALLER

            Start-Process `
                -FilePath ".\${INSTALLER}" ` # Install Docker Desktop 
                -Wait `
                -ArgumentList @(
                    'install'
                    '--quiet'
                    '--accept-license'
                )
            Remove-Item ".\${INSTALLER}" # Clean up the installer file
        } || {
            echo "[❗ERROR❗] Please install Docker Desktop for Windows from https://www.docker.com/products/docker-desktop/ and ensure it's running"
            exit 1
        }
        ;;

      *)
        echo "[❗ERROR❗] Unsupported OS: $(uname -s). Please install Docker manually from https://www.docker.com/products/docker-desktop/"
        exit 1
        ;;
    esac

    echo "Docker is installed !"
    # Wait for docker daemon to be up (optional)
    echo "Waiting for Docker to start..."
    sleep 5
else 
    echo "Docker already installed !"
    sleep 5
fi

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
    
    read -p "Define running port of the website (suggested : port 80 OR 3000) : " PORT
    echo $PORT

else
    REPO_DIR="/home/deployuser/UNIX-FinalProject"
    SITE_DIR="${REPO_DIR%/}/hosted_website"
    PORT="3000"
    
    read -p "input the URL of the website to mirror : " MIRROR_URL
    echo $MIRROR_URL
    
    read -p "Input the website name please : " WEBSITE_NAME
    echo $WEBSITE_NAME
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

echo "--------> chose option"
echo "1 . Mirror a static github page website"
echo "2 . Host a node-based webiste"
read -p "-> " user_ans

if [ $user_ans = 1 ]; then
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

elif [ $user_ans = 2 ]; then
    echo "Creating dockerfile..."

    cat > "${SITE_DIR}/Dockerfile" <<'EOF'
            FROM node:24-alpine3.20
            WORKDIR /app/
            COPY src/ /app/
            RUN npm install
            EXPOSE 3000
            CMD [ "node", "app.js" ]
            EOF

    echo "$dockerfile_content" > "$SITE_DIR/Dockerfile"
    #bash ./6_deploy.sh "$REPO_DIR" "$SITE_DIR" "$MIRROR_URL" "$WEBSITE_NAME" "$PORT"
else
    echo "[❗ERROR❗] invalid answer... Exiting hosting wizard :(";
    exit 1;
fi
