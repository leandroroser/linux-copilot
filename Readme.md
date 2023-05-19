# Linux Copilot

An intelligent and active terminal application for Linux.


![copilot](https://github.com/leandroroser/linux-copilot/assets/10769732/f3bbd9ba-417a-4c75-9d3d-89912d29b89f)



Linux Copilot is a command-line tool for Linux that enables users to generate editable Linux commands using GPT-3. These commands can be executed on-the-fly as regular commands within the same terminal,  providing a pure Linux experience!

One interesting feature of this terminal is its auto-complete functionality. It allows users not only to ask questions but also to edit and execute the generated responses.

Currently, the application was tested in bash and zsh.


Note: This is in state of proof of concept. Expect improvements with time.
Note 2: For some reason (cold start?) the first query tends to fail randomly and then the rest of the queries work as expected. 

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

4. Edit the template.env file in the api directory and move it to .env:
```sh
nano api/template.env
# edit the file here, it has in addition to the key you should add, two other parameters"
# OPENAI_API_KEY=
# MAX_TOKENS=500
# TEMPERATURE=0.7
mv api/template.env api/.env
```

## Usage

1. Start the Linux Copilot API server:

```sh
source chatenv/bin/activate
make start
```

This command will start the API that is used by the chat.sh command.

2. To stop the API server, run:

```sh
make stop
```

3. In other terminal, start using Linux-Copilot with following command:

```sh
./chat.sh
```



This will launch the interactive chat interface. Ask questions about Linux commands, and Linux Copilot will provide code answers.


Contributions are welcome! Feel free to fork the repository and submit pull requests.This is an ongoing project.

---
Please refer to the [License](LICENSE) file for license information.
