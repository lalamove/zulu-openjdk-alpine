FROM alpine:3.9

ENV JAVA_HOME /opt/openjdk-11
ENV PATH $JAVA_HOME/bin:$PATH

# https://jdk.java.net/
ENV JAVA_VERSION 11.0.2
ENV JAVA_URL https://cdn.azul.com/zulu/bin/zulu11.29.11-ca-jdk11.0.2-linux_musl_x64.tar.gz
ENV JAVA_SHA256 23e40024dd7474713121c07f71b4709ad6ef7ad90bcdbe8fc7ef58b558453679

RUN set -eux; \
	\
	wget -O /openjdk.tgz "$JAVA_URL"; \
	echo "$JAVA_SHA256 */openjdk.tgz" | sha256sum -c -; \
	mkdir -p "$JAVA_HOME"; \
	tar --extract --file /openjdk.tgz --directory "$JAVA_HOME" --strip-components 1; \
	rm /openjdk.tgz; \
	\
# https://github.com/docker-library/openjdk/issues/212#issuecomment-420979840
# https://openjdk.java.net/jeps/341
	java -Xshare:dump; \
	\
# basic smoke test
	java --version; \
	javac --version

# https://docs.oracle.com/javase/10/tools/jshell.htm
# https://docs.oracle.com/javase/10/jshell/
# https://en.wikipedia.org/wiki/JShell

CMD ["jshell"]
