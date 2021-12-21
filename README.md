# Data stream splitter in Linux with shell/bash scripting: an example
*By Picohertz Dec 2021*

**This code is explained in details in this video.**\
[https://youtu.be/elzM1ZTIBJk]


A single data stream can be used by multiple data consumers independently.\
Each data consumer can start and stop the consumption at any time and as many times it wants.

<img width=500px src=./datasplitterdiagram.png>

## To run
In the folder that you saved these scripts, run the orchestrator.sh like this:\
```
bash orchestrator.sh
```
### To start the consumers
Consumers are controlled by control signals.\
To start consumer 1 run:
```
echo 1 > signalcon1
```
And to stop it:
```
echo 0 > signalcon1
```
Similar for consumer two.

### Output goes to logfiles
Log files are created under **./logs** folder.
