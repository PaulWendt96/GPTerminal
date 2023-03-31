#!/usr/local/bin/python

"""
Ask GPT anything!

ln -s $(pwd)/ask_gpt.py /usr/local/bin/ask_gpt
"""
import json
import os
import requests
import sys

model = "gpt-3.5-turbo"
temperature = 0.7
if len(sys.argv) > 1:
    content = sys.argv[1]
else:
    content = sys.stdin.read()

key = os.environ.get("OPENAI_KEY", "")
if not key:
    raise EnvironmentError("OPENAI_KEY environment variable not found")

endpoint = "https://api.openai.com/v1/chat/completions"

headers = {"Content-Type": "application/json", "Authorization": f"Bearer {key}"}
data = {
    "model": model,
    "messages": [
        {
            "role": "user",
            "content": content
        }
    ],
    "temperature": temperature
}
response = requests.post(endpoint, headers=headers, data=json.dumps(data))
content = response.json()["choices"][0]["message"]["content"]
print(content)
