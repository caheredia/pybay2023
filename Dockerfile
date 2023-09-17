# STAGING
FROM python:3.10-slim as staging
# install gcc
RUN apt-get update \
	&& apt-get -y install gcc \
	&& rm -rf /var/lib/apt/lists/* 

# DEVELOPMENT
FROM staging as development
ENV \
	PIP_NO_CACHE_DIR=off \
	PIP_DISABLE_PIP_VERSION_CHECK=on \
	PYTHONDONTWRITEBYTECODE=1 \
	VIRTUAL_ENV=/pybay-venv 
ENV \
	POETRY_VIRTUALENVS_CREATE=false \
	POETRY_VIRTUALENVS_IN_PROJECT=false \
	POETRY_NO_INTERACTION=1 \
	POETRY_VERSION=1.4.2

# install poetry 
RUN pip install "poetry==$POETRY_VERSION"
# copy requirements
COPY poetry.lock pyproject.toml ./

# add poetry and venv to path 
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install python packages
RUN python -m venv $VIRTUAL_ENV \
	&& . $VIRTUAL_ENV/bin/activate \
	&& poetry install --no-root

# BUILDER
FROM development as builder
WORKDIR /app
COPY . . 
RUN poetry install
# export build
RUN poetry build --format wheel

# PRODUCTION
FROM staging as production
WORKDIR /app 
COPY --from=builder /app/dist/*.whl ./
RUN pip install ./*.whl
