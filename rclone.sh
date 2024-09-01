#!/bin/bash

cp ~/Downloads/rclone/rclone.conf ~/.config/rclone
rclone mount --daemon school: ~/school
rclone mount --daemon personal: ~/personal