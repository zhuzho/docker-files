FROM python:3

#author info
#MAINTAINER birdben (zhuzhong@quancheng-ec.com)

#RUN pip install --upgrade pip 

#RUN pip install jupyter
#RUN pip install pyodps
#ADD config.ipynb /root

RUN pip install 'pyodps[full]'
ADD init.py /root
ADD matplotlibrc /usr/local/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc
ADD Vera.ttf /usr/local/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf/Vera.ttf
EXPOSE 8888
workdir /root/

RUN python init.py
#RUN rm -rf init.ipynb
#RUN rm -rf init.py


CMD exec jupyter notebook --allow-root --ip=0.0.0.0 --NotebookApp.password='sha1:407ac555f748:2d69b32d52a13290317d138ec2b7ce743fcbaa1e' 
