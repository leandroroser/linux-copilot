init:
	python -m venv chatenv && \
	source chatenv/bin/activate && \
	pip install -r api/requirements.txt
	chmod +x chat.sh
	chmod +x base.sh
start:
	python api/main.py

stop:
	kill -9 $$(lsof -ti :8000) || echo 

clean:
	rm -rf chatenv
