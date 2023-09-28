from typing import Optional

import requests
from requests import Response

from pybay2023.domain.world_time.world_time import TIME_URL


def fetch_date(response: Optional[Response] = None) -> str:
    if response is None:
        response = requests.get(TIME_URL)

    response.raise_for_status()
    date_str = response.json()["dateTime"]

    print(f"PyBay2023, \nThe time is: {date_str}\n")
    return date_str
