FROM python:3.11-alpine
LABEL maintainer="retgal"

# set a directory for the app
WORKDIR /opt/mayer

ENV MAYER_CONFIG "/opt/data/mayer"

# create a volume for the app
VOLUME /opt/data

COPY mayer.py requirements.txt ./
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

CMD python ./mayer.py ${MAYER_CONFIG} -nolog