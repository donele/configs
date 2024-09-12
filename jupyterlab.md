# Running Jupyterlab for remote access

## From Server:

$ jupyter lab --generate-config

from jupyter_server.auth import passwd \
passwd()

cd ~/.jupyter \
$ openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout mykey.key -out mycert.pem


## Edit jupyter_notebook_config.py:

c.NotebookApp.password = u'{hash code of password}' \
c.NotebookApp.keyfile = u'/home/jlee/.jupyter/mykey.key' \
c.NotebookApp.certfile = u'/home/jlee/.jupyter/mycert.pem' \
c.NotebookApp.ip = '0.0.0.0' \
c.NotebookApp.open_browser = False \
c.NotebookApp.port = 8888 \
c.NotebookApp.enable_mathjax = True \
c.NotebookApp.notebook_dir = u'/home/<username>/jupyter_workdir'

## Run jupyterlab:

From commandline: \
$ jupyter lab

From Client: \
Navigate to https://<hostname>:8888

Or: \
$ ssh -L 8888:localhost:8888 <username>@<hostname> \
Then navigate to https://localhost:8888


## From Server:
We can set up a jupyterlab startup service using systemctl. First create a script file that systemctl looks for services:

$ cd /usr/lib/systemd/system \
$ sudo touch jupyterlab.service \
$ sudo chown root:root jupyterlab.service \
Edit the file /usr/lib/systemd/system/jupyterlab.service to look like this:

[Unit] \
Description=Jupyterlab \
[Service] \
ExecStart=/usr/bin/bash -c "cd /home/username; /home/<username>/anaconda3/bin/jupyter lab" \
User=<username> \
Group=users \
[Install] \
WantedBy=default.target

Now enable the jupyterlab.service by running: \
$ sudo systemctl enable jupyterlab

To start and check status of the jupyterlab service: \
$ sudo systemctl start jupyterlab

We can check the status of jupyterlab service by calling: \
$ systemctl status jupyterlab

Whenever systemd script file is updated, we need to do a reload: \
$ sudo systemctl daemon-reload

Firewall: \
$ sudo ufw status \
$ sudo ufw allow from xxx.xxx.xxx.xxx \
$ sudo ufw delete allow from xxx.xxx.xxx.xxx \
$ sudo ufw allow https
