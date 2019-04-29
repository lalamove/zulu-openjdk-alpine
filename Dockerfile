FROM alpine:3.9

ENV JAVA_HOME /opt/openjdk-11
ENV PATH $JAVA_HOME/bin:$PATH

# https://jdk.java.net/
ENV JAVA_VERSION 11.0.3
ENV JAVA_URL https://cdn.azul.com/zulu/bin/zulu11.31.11-ca-jdk11.0.3-linux_musl_x64.tar.gz
ENV JAVA_SHA256 b80079a77e3be7bedaab67cb4005b51da429fc779cbbdd369a36ae1356d73273

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
