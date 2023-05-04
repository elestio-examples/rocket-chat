#set env vars
#set -o allexport; source .env; set +o allexport;

sleep 10s;
echo "Waiting for software to be ready ..."

sed -i 's~ROCKETCHAT_COMMAND~> \
      bash -c \
        "for i in \`seq 1 30\`; do \
          node main.js && \
          s=$$? && break || s=$$?; \
          echo \"Tried $$i times. Waiting 5 secs...\"; \
          sleep 5; \
        done; (exit $$s)"~g' ./docker-compose.yml

sed -i 's~MONGO_COMMAND~mongod --oplogSize 128 --replSet rs0~g' ./docker-compose.yml

sed -i 's~MONGOINIT_COMMAND~> \
      bash -c \
        "for i in \`seq 1 30\`; do \
          mongo mongo/rocketchat --eval \" \
            rs.initiate({ \
              _id: 'rs0', \
              members: [ { _id: 0, host: 'localhost:27017' } ]})\" && \
          s=$$? && break || s=$$?; \
          echo \"Tried $$i times. Waiting 5 secs...\"; \
          sleep 5; \
        done; (exit $$s)"~g' ./docker-compose.yml