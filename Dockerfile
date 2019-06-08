FROM python:3.7.3-stretch

# Here we get all python packages.
RUN pip install --upgrade pip
RUN pip install numpy==1.16.4 scikit-learn==0.21.2 scipy==1.3.0 pandas && \
        rm -rf /root/.cache

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

# Set up the program in the image
COPY program /opt/program
WORKDIR /opt/program

