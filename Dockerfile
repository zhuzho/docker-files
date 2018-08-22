FROM python:2

#author info
#MAINTAINER birdben (zhuzhong@quancheng-ec.com)

RUN pip install --upgrade pip
RUN pip install jupyter
RUN pip install pyodps
#ADD config.ipynb /root
ADD config.py /root

EXPOSE 8888
workdir /root/

RUN python config.py
CMD exec jupyter notebook --allow-root --ip=0.0.0.0 --NotebookApp.password='sha1:407ac555f748:2d69b32d52a13290317d138ec2b7ce743fcbaa1e' 
RUN rm -rf config.*

