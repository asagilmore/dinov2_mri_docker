FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

ARG GIT_ACCESS_TOKEN

RUN apt-get update && \
    apt-get install -y --no-install-recommends git python3-pip && \
    pip install --no-cache-dir torch==2.0.0+cu118 xformers==0.0.18 --extra-index-url https://download.pytorch.org/whl/cu118 && \
    rm -rf /var/lib/apt/lists/*

RUN git config --global credential.helper store && \
    echo "https://${GIT_ACCESS_TOKEN}:x-oauth-basic@github.com" > ~/.git-credentials && \
    git clone https://github.com/asagilmore/dinov2_mri.git /dinov2_mri

RUN pip install --no-cache-dir -r /dinov2_mri/requirements.txt && \
    pip install --no-cache-dir /dinov2_mri/

WORKDIR /dinov2_mri

ENTRYPOINT ["python3", "dinov2/train/train_nifti.py"]

