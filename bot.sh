#!/bin/bash

DROPBOX_URL=*censored*
JENKINS_URL=http://127.0.0.1:8080/job/happybot//lastSuccessfulBuild/artifact/build/libs/happybot-all.jar
JENKINS_DEV_URL=http://127.0.0.1:8080/job/happybot-dev//lastSuccessfulBuild/artifact/build/libs/happybot-dev-all.jar

WEBHOOK_URL=*censored*
AVATAR_URL=https://cdn.discordapp.com/avatars/354736186516045835/ee232e232f4ae04198933d6d465a901a.png

while true
do
java -jar HappyBot.jar
OUT=$?
if [ ${OUT} -eq 10 ]
then
echo "[HappyBot] [Bash] Grabbing Update from Dropbox..."
curl -d '{"username": "happybot-bash", "avatar_url": "${AVATAR_URL}", "content": "Downloading Dropbox Update..."}' -H "Content-Type: application/json" -X POST ${WEBHOOK_URL}
wget -q -O HappyBot.jar ${DROPBOX_URL}
curl -d '{"username": "happybot-bash", "avatar_url": "${AVATAR_URL}", "content": "Finished Dropbox Update!"}' -H "Content-Type: application/json" -X POST ${WEBHOOK_URL}
echo "[HappyBot] [Bash] Update Done."
fi
if [ ${OUT} -eq 20 ]
then
echo "[HappyBot] [Bash] Grabbing Update from Jenkins..."
curl -d '{"username": "happybot-bash", "avatar_url": "${AVATAR_URL}", "content": "Downloading Jenkins Update..."}' -H "Content-Type: application/json" -X POST ${WEBHOOK_URL}
wget -q -O HappyBot.jar ${JENKINS_URL}
curl -d '{"username": "happybot-bash", "avatar_url": "${AVATAR_URL}", "content": "Finished Jenkins Update!"}' -H "Content-Type: application/json" -X POST ${WEBHOOK_URL}
echo "[HappyBot] [Bash] Update Done."
fi
if [ ${OUT} -eq 25 ]
then
echo "[HappyBot] [Bash] Grabbing Update from Jenkins [DEV]..."
wget -q -O HappyBot.jar ${JENKINS_DEV_URL}
echo "[HappyBot] [Bash] Update Done."
fi
echo "[HappyBot] [Bash] Rebooting in:"
for i in 3 2 1
do
echo "[HappyBot] [Bash] $i..."
sleep 1
done
echo "[HappyBot] [Bash] Rebooting!"
done