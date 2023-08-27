import requests
from pybay2023.domain.world_time.world_time import TIME_URL


def fetch_date():
    r = requests.get(TIME_URL)
    r.raise_for_status()
    return r.json()["currentDateTime"]
