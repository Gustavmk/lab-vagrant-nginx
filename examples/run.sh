# BASE 
ansible-playbook -i ansible/inv.yml ansible/pb-docker.yml 

# DB
ansible-playbook -i ansible/inv.yml ansible/pb-db.yml 

# WEB 
ansible-playbook -i ansible/inv.yml ansible/pb-web.yml


# LB
ansible-galaxy install nginxinc.nginx
ansible-playbook -i ansible/inv.yml ansible/pb-lb-role.yml
ansible-playbook -i ansible/inv.yml ansible/pb-lb-config.yml
ansible-playbook -i ansible/inv.yml ansible/pb-lb-monitoring.yml