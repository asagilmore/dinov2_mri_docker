FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

ARG GIT_ACCESS_TOKEN

RUN git config --global url."https://${GIT_ACCESS_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"

RUN git clone https://github.com/asagilmore/dinov2_mri.git /dinov2_mri

RUN apt-get update && \
    apt-get install -y git python3-pip && \
    pip install torch==2.0.0+cu118 xformers==0.0.18 --extra-index-url https://download.pytorch.org/whl/cu118

RUN pip install mmcv==2.0.0 mmsegmentation==1.0.0

RUN pip install -r /dinov2_mri/requirements.txt && \
    pip install /dinov2_mri/