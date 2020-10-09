import requests

url = "https://github.com/aws/aws-sam-cli/releases/download/v1.6.2/aws-sam-cli-1.6.2.sierra.bottle.tar.gz"
with requests.get(url, allow_redirects=True) as response, open("python_log.txt", "wb") as output:
        output.write(response.content)
