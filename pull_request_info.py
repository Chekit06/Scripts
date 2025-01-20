import requests

response = requests.get("https://api.github.com/repos/kubernetes/kubernetes/pulls")

detail = response.json()

for i in range(len(detail)):
    print(detail[i]["user"]["login"])

