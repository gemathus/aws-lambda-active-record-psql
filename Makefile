image:
	docker build -t lambda-active-record-2 .

shell:
	docker run --rm -it -v $$PWD:/var/task -w /var/task lambda-active-record-2

install:
	docker run --rm -it -v $$PWD:/var/task -w /var/task lambda-active-record-2 make _install

test:
	docker run --rm -it -v $$PWD:/var/task -w /var/task lambda-active-record-2 make _test

clean:
	rm -rf .bundle/
	rm -rf vendor/
	rm -rf lib/

deploy:
	rm -f deploy.zip
	zip -q -r deploy.zip . -x .git/\*
	aws lambda update-function-code \
			--region us-east-1 \
			--function-name test-active-record \
			--zip-file fileb://deploy.zip

invoke:
	aws lambda invoke \
		--region us-east-1 \
		--function-name test-active-record /dev/stdout

_install:
	bundle config --local build.pg --with-pg-config=/usr/pgsql-10/bin/pg_config
	bundle config --local silence_root_warning true
	bundle install --path vendor/bundle --clean
	mkdir -p /var/task/lib
	cp -a /usr/pgsql-10/lib/*.so.* /var/task/lib/
	cp /usr/lib64/liblber-2.4.so.2 /var/task/lib
	cp /usr/lib64/libsmime3.so /var/task/lib
	cp /usr/lib64/libssl3.so /var/task/lib
	cp /usr/lib64/libnss3.so /var/task/lib
	cp /usr/lib64/libldap_r-2.4.so.2 /var/task/lib
	cp /usr/lib64/libsasl2.so.3 /var/task/lib

_test:
	ruby -e "require 'lambda_function'; puts lambda_handler(event: nil, context: nil)"
