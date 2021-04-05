FROM python:3.9.3

ENV ANSIBLE_HOST_KEY_CHECKING=False

RUN apt update -y && apt install -y vim sudo
RUN useradd -r ansible-runner && mkdir -p /home/ansible-runner/roles/ && echo 'ansible-runner ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/ansible-runner
ADD requirements.txt /home/ansible-runner/requirements.txt
RUN pip3 install -r /home/ansible-runner/requirements.txt
ADD ./server-heartbeat/ /home/ansible-runner/roles/role
ADD playbook.yml hosts /home/ansible-runner/
WORKDIR /home/ansible-runner/
RUN sed -i 's/server-heartbeat/role/' playbook.yml
RUN chown -R ansible-runner:ansible-runner /home/ansible-runner


USER ansible-runner
CMD ansible-playbook playbook.yml -i hosts
