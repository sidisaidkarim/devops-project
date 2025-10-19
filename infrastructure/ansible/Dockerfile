FROM python:3.10-slim

RUN apt-get update && apt-get install -y openssh-client

RUN pip install --no-cache-dir ansible


WORKDIR /ansible


COPY playbook.yml /ansible/playbook.yml
COPY inventory.ini /ansible/inventory.ini
COPY entrypoint.sh /ansible/entrypoint.sh

RUN chmod +x /ansible/entrypoint.sh


CMD ["/ansible/entrypoint.sh"]

# docker run --rm -v D:/téléchargements/devops_instances.pem:/root/.ssh/ma-cle.pem:ro ansible-runner
