#!/bin/bash

echo "setting 19-19"
ssh root@node19-19 "/root/scripts/if-setup/setup-ifs.sh 1"

echo "setting 19-20"
ssh root@node19-20 "/root/scripts/if-setup/setup-ifs.sh 2"

echo "setting 20-19"
ssh root@node20-19 "/root/scripts/if-setup/setup-ifs.sh 3"

echo "setting 20-20"
/root/scripts/if-setup/setup-ifs.sh 4