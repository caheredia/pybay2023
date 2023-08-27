FROM python:3.10

ENV PIP_NO_CACHE_DIR=off \
	PIP_DISABLE_PIP_VERSION_CHECK=on \
	PYTHONDONTWRITEBYTECODE=1 \
	VIRTUAL_ENV=/pybay-venv \
	POETRY_HOME=/opt/poetry \
	POETRY_VIRTUALENVS_CREATE=false \
	POETRY_VIRTUALENVS_IN_PROJECT=false \
	POETRY_NO_INTERACTION=1 \
	POETRY_VERSION=1.4.2

# System deps:
# install poetry in it's own venv
RUN command python -m venv $POETRY_HOME \
	&& $POETRY_HOME/bin/pip install "poetry==$POETRY_VERSION"

# Copy requirements
COPY poetry.lock pyproject.toml ./

# Add poetry and venv to path 
ENV PATH="$VIRTUAL_ENV/bin:$POETRY_HOME/bin:$PATH"

# Install python packages
RUN python -m venv $VIRTUAL_ENV \
	&& . /$VIRTUAL_ENV/bin/activate \
	&& poetry install --no-root
