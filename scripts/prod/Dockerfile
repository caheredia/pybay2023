FROM python:3.10-slim as builder

ENV PIP_NO_CACHE_DIR=off \
	PIP_DISABLE_PIP_VERSION_CHECK=on \
	PYTHONDONTWRITEBYTECODE=1 \
	VIRTUAL_ENV=/pybay-venv \
	POETRY_VIRTUALENVS_CREATE=false \
	POETRY_VIRTUALENVS_IN_PROJECT=false \
	POETRY_NO_INTERACTION=1 \
	POETRY_VERSION=1.4.2

# install gcc
RUN apt-get update \
	&& apt-get -y install gcc \
	&& rm -rf /var/lib/apt/lists/* 
# System deps:
RUN pip install "poetry==$POETRY_VERSION"
# Copy files 
WORKDIR /code
COPY . .  

# Add poetry and venv to path 
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install python packages
RUN python -m venv $VIRTUAL_ENV \
	&& . $VIRTUAL_ENV/bin/activate \
	&& poetry install 
# export build
RUN poetry build --format wheel

# Separate dependencies from source code
FROM python:3.10-slim

# install gcc
RUN apt-get update \
	&& apt-get -y install gcc \
	&& rm -rf /var/lib/apt/lists/* 
WORKDIR /code 
COPY --from=builder /code/dist/*.whl ./
RUN pip install ./*.whl
