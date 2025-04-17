import requests
import json

def send_results(results, webhook_url):
    # Format test results for Teams
    test_summary = {
        "title": f"CRT Test Results: {results.suite_name}",
        "text": f"Status: {results.suite_status}<br>"
               f"Test Cases: {results.tests_total}<br>"
               f"Passed: {results.tests_passed}<br>"
               f"Failed: {results.tests_failed}"
    }
    
    requests.post(webhook_url, json=test_summary)
