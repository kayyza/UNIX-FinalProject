#!/bin/bash

RED='\033[1;91m'
ORANGE='\033[0;33m]'
GREEN='\033[1;32m'
NC='\033[0m'

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
            echo -e "${ORANGE} Homebrew not working or not installed. Trying to install through terminal...${NC}"
            curl -fsSL "$DMG_URL" -o "$DMG_PATH" #grabs the Docker installation from the website
            sudo hdiutil attach "$DMG_PATH" #mounts the installation
            sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license #runs the installation and automatically accepts the license
            sudo hdiutil detach /Volumes/Docker
            rm -f "$DMG_PATH" # recursive cleanup
        }
        else
          echo -e "${RED} [❗ERROR❗] unable to automatically install Docker -> please install Docker Desktop manually from https://www.docker.com/products/docker-desktop/ ${NC}"
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
            echo -e "${RED} [❗ERROR❗] Please install Docker Desktop for Windows from https://www.docker.com/products/docker-desktop/ and ensure it's running ${NC}"
            exit 1
        }
        ;;

      *)
        echo -e "${RED} [❗ERROR❗] Unsupported OS: $(uname -s). Please install Docker manually from https://www.docker.com/products/docker-desktop/ ${NC}"
        exit 1
        ;;
    esac

    echo -e "${GREEN} Docker is installed ! ${NC}"
    # Wait for docker daemon to be up (optional)
    echo "Waiting for Docker deamon to start..."
    echo "."
    echo "."
    echo "."
    sleep 5
else 
    echo -e "${GREEN} Docker already installed ! ${NC}"
    sleep 5
fi
