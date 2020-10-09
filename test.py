import requests

url = "https://github.com/actions/virtual-environments/issues/1745"
with requests.get(url, allow_redirects=True) as response, open("python_log.txt", "wb") as output:
        output.write(response.content)
