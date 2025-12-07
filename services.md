
sudo cp /home/knight/AiTaxonomy/aitaxonomy.service /etc/systemd/system/aitaxonomy.service
sudo systemctl daemon-reload
sudo systemctl enable --now aitaxonomy.service
sudo systemctl status aitaxonomy.service
sudo journalctl -u aitaxonomy.service -f