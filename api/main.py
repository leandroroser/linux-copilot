import os

import openai
from fastapi import FastAPI, HTTPException
import uvicorn
from fastapi.responses import JSONResponse
from dotenv import load_dotenv

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")


app = FastAPI()

def generate_prompt(q):
    return f"""You are a linux command promt assistant. The user will ask you question
                and you shuld only respond only with code that the user can execute in 
                the bash command line, without any explanation .
                I need the code to be executable in bash directly, use properly single and double quotes when needed. The code should be executable with copy and paste.
                Below is the question:
                {q}
                """
                
@app.get("/")
async def not_implemented():
    raise HTTPException(status_code=501, detail="Not Implemented")

@app.post("/")
async def run(data: dict):
    input_text = data.get("data", "")
    response = openai.Completion.create(
        model="text-davinci-003",
        prompt=generate_prompt(data),
        temperature=0.6,
    )
    result = response.choices[0].text.strip()
    return JSONResponse(content={"result":result})


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
