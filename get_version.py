import requests
r = requests.get(
    'https://checkpoint-api.hashicorp.com/v1/check/consul?arch=amd64&os=linux'
)
print(r.json()['current_version'])
