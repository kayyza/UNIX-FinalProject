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

echo "--------> chose option"
echo "1 . Mirror a static github page website"
echo "2 . Host a node-based webiste"
read -p "-> " user_ans

if [ $user_ans = 1 ]; then
    echo "static setup choosen. Starting wizard..."
    bash ./0_opt1_setupStatic.sh
    ;;

elif [ $user_ans = 2 ]; then
    echo "node setup choosen. Starting wizard..."
    bash ./0_opt2_setupNode.sh
    ;;

else
    echo "[❗ERROR❗] invalid answer... Exiting hosting wizard :(";
    exit 1;
fi
