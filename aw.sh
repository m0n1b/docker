sudo systemctl stop acunetix
sudo cp wvsc /home/acunetix/.acunetix/v_240427095/scanner/wvsc
sudo chown acunetix:acunetix /home/acunetix/.acunetix/v_240427095/scanner/wvsc
sudo chmod +x /home/acunetix/.acunetix/v_240427095/scanner/wvsc
sudo rm /home/acunetix/.acunetix/data/license/* 
sudo cp license_info.json /home/acunetix/.acunetix/data/license/
sudo cp wa_data.dat /home/acunetix/.acunetix/data/license/
sudo chown acunetix:acunetix /home/acunetix/.acunetix/data/license/license_info.json
sudo chown acunetix:acunetix /home/acunetix/.acunetix/data/license/wa_data.dat
sudo chmod 444 /home/acunetix/.acunetix/data/license/license_info.json
sudo chmod 444 /home/acunetix/.acunetix/data/license/wa_data.dat
sudo chattr +i /home/acunetix/.acunetix/data/license/license_info.json 
sudo chattr +i /home/acunetix/.acunetix/data/license/wa_data.dat
sudo systemctl start acunetix
