# Linux Copilot

Linux Copilot is a command line tool for Linux that allows users to generate Linux commands using GPT-3 that can be run on the fly as a regular command in the same terminal after user confirmation.

## Prerequisites

Before using Linux Copilot, ensure that you have the following prerequisites installed on your Linux system:
- Python 3.6 or higher
- Make utility

## Installation

1. Clone the Linux Copilot repository:

```sh
git clone https://github.com/your-username/linux-copilot.git
```

2. Navigate to the project directory:

```sh
cd linux-copilot
```

3. Set up the virtual environment and install the dependencies:

```sh
make init
```

4. Add a .env file in the api directory with your openai key:
```sh
OPENAI_API_KEY=YOUR_KEY_HERE
```


## Usage

1. Start the Linux Copilot API server:

```sh
make start
```

This command will start the API that is used by the chat.sh command.

2. To stop the API server, run:

```sh
make stop
```

3. Start chatting by running the following command:

```sh
./chat.sh
```



This will launch the interactive chat interface. Ask questions about Linux commands, and Linux Copilot will provide real-time suggestions and answers.

![screenshot](https://github.com/leandroroser/linux-copilot/assets/10769732/7c0a6d8c-0301-4f4b-bf90-8ddf351b3340)


Contributions are welcome! Feel free to fork the repository and submit pull requests.This is an ongoing project.

---
Please refer to the [License](LICENSE) file for license information.
