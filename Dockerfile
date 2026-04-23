FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/local/bin/python

RUN git clone https://github.com/rosalindfranklininstitute/volume-segmantics.git /opt/volume-segmantics
WORKDIR /opt/volume-segmantics

RUN pip install --no-cache-dir poetry

RUN pip install --no-cache-dir \
    torch==2.7.1 \
    --index-url https://download.pytorch.org/whl/cu118

RUN poetry config virtualenvs.create false \
    && poetry install --no-root

WORKDIR /root

CMD ["/bin/bash"]
