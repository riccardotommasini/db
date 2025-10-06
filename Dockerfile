FROM mcr.microsoft.com/devcontainers/base:ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# System deps
RUN apt-get update && apt-get install -y \
    # PostgreSQL client + headers for psycopg2
    postgresql-client \
    libpq-dev \
    # Python toolchain
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

# Create a workspace
RUN mkdir -p /workspace
WORKDIR /workspace

# Create a dedicated virtual environment and install Python packages
# - jupyter + ipykernel to provide a kernel inside the container
# - psycopg2 (compiled against system libpq)
ENV VENV_PATH=/opt/venv
RUN python3 -m venv $VENV_PATH \
    && $VENV_PATH/bin/pip install --upgrade pip \
    && $VENV_PATH/bin/pip install --no-cache-dir \
        jupyter ipykernel psycopg2 pandas\
    && $VENV_PATH/bin/python -m ipykernel install \
        --name=python3 \
        --display-name="Python 3 (container)"

# Ensure the venv is on PATH for all subsequent commands/shells
ENV PATH="${VENV_PATH}/bin:${PATH}"
