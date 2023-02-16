#!/bin/bash

sudo usermod -aG sudo $user
sudo usermod -aG docker $user
sudo chmod u+x /usr/local/bin/docker-compose

