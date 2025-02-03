# Script de Backup do Proxmox - Montagem/Desmontagem de Disco com o Envio de E-mail 

Gurizada esse o script é para facilitar a vida dos SysAdmin que cuidam de proxmox on-primisse e fazem backup em HD externo. 
É arquivo simples, sem muita frescura que resolveu um problema tive tempos atrás em em cliente, o qual a premissa era montar o HD, realizar o backup, demontar o HD e enviar e-mail o status da tarefa.

Espero que ajude, Valew!

### Pre-requisitos:

#### 1 - Instalar o sendEmail

    apt install sendemail

#### 2 - Criar diretorios para salvar os logs e para a montagem do HD.

    mkdir /var/log/backup-proxmox/ /mnt/hd-externo

#### 3 - Identificar o UUID do seu HD externo

    blkid

#### 4 - Criar o script e configurar a parmissão

    touch /etc/cron.d/vzdump.sh

#### 5 - Copiar o conteudo do script disponibilizado para o seu script

#### 6 - Alterar o UUID, pastas e as demais opções do sendEmail.
