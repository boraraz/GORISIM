import requests

url = "https://0e86-88-241-212-87.ngrok-free.app/PythonProject/ağaç.mp4"
response = requests.post(url)
print(response)
with open("video.mp4", "wb") as f:
    print("a")
    f.write(response.content)