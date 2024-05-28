FROM python:3.8
WORKDIR /app

RUN pip install --upgrade pip
# Sao chép mã nguồn cuối cùng để không làm mất cache của các bước cài đặt gói
COPY . .
# RUN pip install jax[tpu] -f https://storage.googleapis.com/jax-releases/libtpu_releases.html


# Chạy tệp kiểm tra TPU

# Cài đặt dự án với các phần phụ thuộc bổ sung
RUN pip install -e .["endpoint"]

# Cài đặt các gói bổ sung
RUN pip install ml-dtypes==0.2.0
RUN pip install --upgrade transformers jax jaxlib


# Xóa cache của huggingface nếu cần thiết
RUN rm -rf ~/.cache/huggingface

# Cài đặt ffmpeg để chuyển đổi video
RUN apt-get update && apt-get install -y ffmpeg
# Mở cổng 6789
EXPOSE 6789

ENV TPU_IP_ADDRESS=10.128.0.4
ENV XRT_TPU_CONFIG="tpu_worker;0;$TPU_IP_ADDRESS:8470"

CMD ["python", "app/app.py"]