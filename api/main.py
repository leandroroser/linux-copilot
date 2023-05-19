import os
import openai
from fastapi import FastAPI, HTTPException
import uvicorn
from fastapi.responses import JSONResponse
from dotenv import load_dotenv

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")
max_tokens = int(os.getenv("MAX_TOKENS"))
temperature = float(os.getenv("TEMPERATURE"))

app = FastAPI()

def generate_prompt(q):
    prompt=[{'role': 'system', 'content':"""You are a Linux command prompt assistant. Your task is to provide the corresponding Linux command based on the user's input/question.
            You must stay in that role.
            The user will provide you with a question in a json with structure {{"question": "THE QUESTION"}}
            Follow the following instructions:
                1. Respond with a single executable command and don't add any explanations. 
                2. The response can't contain things preceding the code like Response:, Anwser:, or similar, if that is not part of the code. Only the required code is allowed.
                3. The code should be bash executable. 
                4. Use properly single and double quotes when needed, but generate only valid code as in the example below: 
                    User: I need to list the files in my current folder
                    Valid response: ls
                    Invalid response: "Answer: ls"
                    Invalid response: "ls"
                    Invalid response: 'ls'          
                5. If you dont know the question your response should be empty.
                6. The user should be able to run the output with copy-paste in a terminal and the code need to be valid.
            """},
            {'role':'user', 'content': f"{{'question': {q}}}"}]
    return prompt
                
@app.get("/")
async def not_implemented():
    raise HTTPException(status_code=501, detail="Not Implemented")

@app.post("/")
async def run(data: dict):
    input_text = data.get("data", "")
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=generate_prompt(input_text),
        temperature=temperature,
        max_tokens=max_tokens
    )
    result = response.choices[0].message.content.strip()
    return JSONResponse(content={"result":result})


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
