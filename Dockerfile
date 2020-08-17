FROM python:3.7

ENV NB_PREFIX /
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && \
    apt-get -yqq install krb5-user libpam-krb5 && \
    apt-get -yqq clean && \
    mv /etc/krb5.conf /etc/krb5-backup.conf && \
    mkdir /home/jovyan

COPY krb5.conf /etc/krb5.conf
WORKDIR /home/jovyan

COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

EXPOSE 8888

CMD ["sh","-c", "jupyter notebook --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]