import unittest
from pathlib import Path

from requests import Response

from pybay2023.service.cli import fetch_date


class TestFetchDate(unittest.TestCase):
    def test_fetch_date(self):
        response_json_path = Path("tests", "mock_response.json")
        test_response = Response()
        test_response.status_code = 200
        test_response._content = response_json_path.read_bytes()

        date_str = fetch_date(test_response)

        self.assertEqual(date_str, "2023-09-27T22:00:29.7077988")
