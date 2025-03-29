import requests

# Automatically downloads the model folder
url = 'https://www.dropbox.com/scl/fo/niu2jgewsdu6nkeo778oj/ADes451jLE0NMz-ABfU6PSg?rlkey=w0hbi7ynaey0bn0soav3r604d&st=p1fwnos3&dl=1'
output_path = 'models/model.tar.gz'  # set the file path for model

# Send HTTP request to download the model
response = requests.get(url)
if response.status_code == 200:
    with open(output_path, 'wb') as file:
        file.write(response.content)
    print(f"Model downloaded successfully")
else:
    print(f"Failed to download model. Status code: {response.status_code}")
