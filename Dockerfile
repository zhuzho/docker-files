FROM python:2
RUN pip install --upgrade pip
RUN pip install jupyter
RUN pip install pyodps
EXPOSE 8888
workdir /root/
CMD exec jupyter notebook --allow-root --ip=0.0.0.0
