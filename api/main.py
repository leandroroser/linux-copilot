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
    return f"""
                You are a Linux command prompt assistant. Your task is to provide the corresponding Linux command based on the user's input/question. 
                Follow the follow instructions:
                1. Please respond with a single executable command and dont add any explanations. 
                2. The response can't contain things preceding the code like Anwser:, etc. Show only the command.
                3. The code should be bash executable. 
                4. Use properly single and double quotes when needed. 
                5. The code should be executable with copy and paste.
                6. If you dont know the question your response should be empty".
                7. The user should be able to run the output with copy-paste.
                Examples:
                User: I need to list the files in my current folder
                Valid response: "ls"
                Invalid response: "Answer: ls"
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
