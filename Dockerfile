FROM gcr.io/kubeflow-images-public/tensorflow-2.1.0-notebook-gpu:1.0.0

USER root

ENV NB_PREFIX /

RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils

RUN apt-get -yqq install krb5-user libpam-krb5 && \
    apt-get -yqq clean && \
    mv /etc/krb5.conf /etc/krb5-backup.conf

COPY krb5.conf /etc/krb5.conf
WORKDIR /home/jovyan

USER jovyan

EXPOSE 8888

CMD ["sh","-c", "jupyter notebook --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]
