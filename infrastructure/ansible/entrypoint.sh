#!/bin/bash
# Copier la clé pour corriger les permissions
cp /root/.ssh/ma-cle.pem /root/.ssh/ma-cle-corrected.pem
chmod 400 /root/.ssh/ma-cle-corrected.pem

# Lancer Ansible avec la clé corrigée
ansible-playbook -i inventory.ini playbook.yml --private-key /root/.ssh/ma-cle-corrected.pem
