import requests
from dotenv import load_dotenv

load_dotenv()
token = os.getenv("mineru_token")

def pdf2markdown(pdf_url):
    url = "https://mineru.net/api/v4/extract/task"
    header = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {token}"
    }
    data = {
        "url": pdf_url,
        "model_version": "vlm"
    }

    res = requests.post(url,headers=header,json=data)
    print(res.status_code)
    print(res.json())
    print(res.json()["data"])
    # 这里返回的应该是task_id
    return res.json()["data"]