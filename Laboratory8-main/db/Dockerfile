FROM mysql:8.0-debian

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      rsync \
      inotify-tools && \
    rm -fR /var/lib/apt/lists/*

COPY utf8.cnf /etc/mysql/mysql.conf.d/
COPY kingsCS-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/kingsCS-entrypoint.sh && \
    ln -sf usr/local/bin/kingsCS-entrypoint.sh /entrypoint.sh

RUN echo 'export PS1="\[$(tput bold)\]\[\033[38;5;11m\]\u@cmpt310_db$(tput sgr0)\]:\w\\$ "' >> /root/.bashrc

ENTRYPOINT ["kingsCS-entrypoint.sh"]

WORKDIR /sql-initdb.d

EXPOSE 3306

CMD ["mysqld"]