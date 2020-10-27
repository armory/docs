>Before you execute the command below, you need to set permissions on the host (local) directories mapped to the Docker container. These directories must allow for modification from within the container.  The `~/.hal` folder within
the *host (local) system directory* needs write permissions (`chmod 777
~/.hal`), or you will encounter issues when attempting to execute a `hal deploy
apply` from within the container.
