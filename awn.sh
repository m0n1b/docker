- sudo cp wvsc /home/acunetix/.acunetix/v_240514098/scanner/wvsc
  - sudo chown acunetix:acunetix /home/acunetix/.acunetix/v_240514098/scanner/wvsc
  - sudo chmod +x /home/acunetix/.acunetix/v_240514098/scanner/wvsc

6) Time to add licenses:
  - sudo rm /home/acunetix/.acunetix/data/license/* (Pay attention to copy and paste right, this can damage your entire OS!!!)
  - sudo cp license_info.json /home/acunetix/.acunetix/data/license/
  - sudo cp wa_data.dat /home/acunetix/.acunetix/data/license/
  - sudo chown acunetix:acunetix /home/acunetix/.acunetix/data/license/license_info.json
  - sudo chown acunetix:acunetix /home/acunetix/.acunetix/data/license/wa_data.dat
  - sudo chmod 444 /home/acunetix/.acunetix/data/license/license_info.json
  - sudo chmod 444 /home/acunetix/.acunetix/data/license/wa_data.dat
  - sudo chattr +i /home/acunetix/.acunetix/data/license/license_info.json (Pay attention to copy and paste right, this can damage your entire  OS!!!)
  - sudo chattr +i /home/acunetix/.acunetix/data/license/wa_data.dat
