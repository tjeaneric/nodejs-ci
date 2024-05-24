#!/bin/sh

# Check if node is installed
if type node > /dev/null 2>&1 && which node > /dev/null 2>&1 ;then
    node -v
    echo "node is installed, skipping..."
else
    echo "install node"
    if [ "$package_manager" = "apt-get" ]; then
        echo "Installing Node.js with apt-get..."
        curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install nodejs -y
    fi
    
fi


# Check if git command exists
if command -v git >/dev/null 2>&1; then
  echo "Git is installed."
else
  echo "Git is not installed."
    if [ "$package_manager" = "apt-get" ]; then
        echo "Installing Git with apt-get..."
        sudo apt-get update
        sudo apt-get install git -y
    fi
fi


repo_url="https://github.com/rwieruch/node-express-server-rest-api"

# Check if a URL argument is provided
if [ -z "$repo_url" ]; then
  echo "Usage: $0 <repository_url>"
  exit 1
fi

# Clone the repository using the provided URL
git clone "$repo_url"

# Check the exit code of the git clone command
if [ $? -eq 0 ]; then
  echo "Successfully cloned repository: $repo_url"
else
  echo "Failed to clone repository: $repo_url"
fi


# Check for package.json
if [ ! -f "package.json" ]; then
  echo "Error: package.json not found."
  exit 1
fi

# Install dependencies using npm
npm install

# Check the exit code of npm install
if [ $? -eq 0 ]; then
  echo "Successfully installed dependencies."
else
  echo "Failed to install dependencies."
fi


# Set the path to your .env file (optional, adjust if needed)
dotenv_path=".env"

# Check if .env file exists
if [ ! -f "$dotenv_path" ]; then
  echo "Warning: .env file not found at '$dotenv_path'."
  exit 0  # Exit without error (optional, adjust as needed)
fi

# Load environment variables from .env file
export $(grep -v '^#' "$dotenv_path" | awk -F '=' '{print $1"="$2}')

# Print confirmation message (optional)
echo "Loaded environment variables from .env"