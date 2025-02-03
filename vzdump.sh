#!/bin/bash

BD=/var/log/backup-proxmox/backup.$(date +%d-%m-%Y-%H:%M).log

echo "====================================" >> $BD
echo "=======INICIO ROTINA DE BACKUP======" >> $BD
echo "====================================" >> $BD

echo "" >> $BD

echo "Montando HD de Backup" >> $BD
mount UUID=UUUUUUUUUU-UUUUUUUUUUU-IIIIIII-DDDDDD-000000000000 /tmp/hd_externo/ >> $BD
echo "=============//================" >> $BD

echo "" >> $BD

if [ $(df -h | grep hd_externo | wc -l) == 1 ]; then
        echo "HD Montado" >> $BD
        echo "=============//================" >> $BD
        df -h >> $BD
        echo "=============//================" >> $BD
        echo "Realizando Backup" >> $BD
        vzdump 100 111 101 102 103 --compress lzo --mailnotification always --storage BKP-NEW --mode snapshot --mailto email@dominio.com.br >> $BD
        echo "=============//================" >> $BD
        echo "Arquivos de Backup" >> $BD
        echo "=============//================" >> $BD
        ls -lh /tmp/hd_externo/dump/ >> $BD
        echo "=============//================" >> $BD
        echo "Backup Finalizado" >> $BD
        echo "=============//================" >> $BD
else
    echo "HD não montado" >> $BD
        echo "=============//================" >> $BD
        echo "Finalizando Rotina" >> $BD
        echo "=============//================" >> $BD
        df -h >> $BD
        exit;
fi;

STATUS="BACKUP REALIZADO COM SUCESSO"
if [ $(ls -lh /tmp/hd_externo/dump/ | grep $(date +%Y_%m_%d) | grep tar.lzo | wc -l) == 0 ]; then
        STATUS="ERRO NO BACKUP"
fi;


echo "Desmontando HD de Backup" >> $BD
umount UUID=UUUUUUUUUU-UUUUUUUUUUU-IIIIIII-DDDDDD-000000000000 >> $BD
echo "=============//================" >> $BD
df -h >> $BD
echo "=============//================" >> $BD

echo "" >>$BD

echo "============Enviando E-mail com Status da Tarefa===========" >> $BD

SMTP_SERVER=email-smtp.us-east-1.amazonaws.com:587
USER=AKI****************ALQ
PASSWORD=AmILFg***************************EkTV/o
SENDER=email@dominio.com.br
SUBJECT="ASSUNTO "$STATUS
MESSAGE=$STATUS
ANEXO=$BD
#RECIPIENTS=$2
RECIPIENTS=email@dominio.com.br

/usr/bin/sendEmail -v -s $SMTP_SERVER -xu $USER -xp $PASSWORD -f $SENDER -u $SUBJECT -t $RECIPIENTS -m $MESSAGE -a $ANEXO
