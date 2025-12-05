*********************************************************
Linux
*********************************************************

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.10 python3.10-venv
python3.10 --version
python3.10 -m venv .venv
source .venv/bin/activate
pip install -r ./requirements-gpu.txt




*********************************************************
Widnows
*********************************************************
winget install Python.Python.3.10
py -3.10 --version
py -3.10 -m venv .venv
.venv\Scripts\activate
pip install -r ./requirements-gpu.txt
