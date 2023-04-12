#!/bin/sh                                                         
for VM in $(VBoxManage list runningvms | awk -F\{ '{print $2}' | sed -e 's/}//g');
do {  
  VMNAME="$(VBoxManage showvminfo ${VM} --machinereadable | awk -F\= '/^name/{print $2}')"
  VMIP=$(VBoxManage guestproperty get ${VM} "/VirtualBox/GuestInfo/Net/0/V4/IP" | sed -e 's/Value: //g')
  printf "VM-IP: %-16s VM-Name: %-50s\n" "${VMIP}" "${VMNAME}"
} done


for f in $(VBoxManage list runningvms | awk -F\" '{print $2}'); do
      echo "$f:"
      VBoxManage guestproperty enumerate "$f" | grep IP
    done
