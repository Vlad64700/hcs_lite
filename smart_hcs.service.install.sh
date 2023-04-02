#!/bin/bash

sudo cp smart_hcs.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable smart_hcs.service
