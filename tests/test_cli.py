from pybay2023.service.cli import fetch_date
import unittest
from requests import Response
from pathlib import Path

class TestFetchDate(unittest.TestCase):
    def test_fetch_date(self):
        response_json_path = Path("tests", "mock_response.json")
        test_response = Response()
        test_response.status_code = 200
        test_response._content = response_json_path.read_bytes()
        date_str = fetch_date(test_response)

        self.assertEqual(date_str , "2023-09-24T00:53-07:00")