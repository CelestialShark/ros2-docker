**Modified version to mount `../container-mount` of this directory as `~/mount-point`**
**Only configured to work on linux**
Currently, when switching between working in the container and on the host system,
you will have to manually change the ownership of the file. by:
```bash
# In the container
sudo chown -R student ~/mount-point

# Host system
sudo chown -R [username_here] container-mount
```

# A Docker Container for ROS 2 Jazzy

## Installation and Setup

For installation and setup instructions, click on the link below as appropriate for your system: 

- [Linux](./docs/linux.md)
- [MacOS](./docs/mac.md)

## FAQ

- If you cannot open Docker desktop on MacOS and its being marked as malware - follow this issue https://github.com/docker/for-mac/issues/7520
- The password for the student user is `password`.

## Acknowledgments

Many thanks to [Atri Hegde](https://github.com/hegde-atri), for coming up with this solution. This version is an adaptation of [Atri's original approach](https://github.com/hegde-atri/ros2-docker), adapted for ROS 2 Jazzy.    