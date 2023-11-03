# Use the specified image as the base
FROM mcr.microsoft.com/devcontainers/base:bullseye

# Set environment variables, if any
# ENV MY_ENV_VAR=my_value

# Run package updates and install packages
RUN apt-get update 


CMD code --install-extension ms-mssql.mssql

USER vscode
RUN curl https://run.spawn.cc/install | sh
ENV PATH="/home/vscode/.spawnctl/bin:$PATH"

# Expose any ports the app is expecting to be served on
# EXPOSE 8080

# Set the default command for the container
# CMD ["my-command"]

