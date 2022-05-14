FROM python:3.6
WORKDIR /app
COPY requirements.txt /app
#RUN python -m pip install --upgrade pip
RUN pip install -r ./requirements.txt

COPY app.py /app
CMD ["python", "app.py"]