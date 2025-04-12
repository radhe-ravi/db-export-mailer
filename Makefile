run:
	bash bin/run.sh

clean:
	rm -rf *.zip csv_exports_*

lint:
	shellcheck bin/run.sh lib/*.sh