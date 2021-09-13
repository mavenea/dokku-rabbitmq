FROM rabbitmq:3.8.0-management

RUN set eux; \
# enable rabbitmq_stomp plugin
    rabbitmq-plugins enable rabbitmq_stomp; \
# enable rabbitmq_web_stomp plugin
	rabbitmq-plugins enable rabbitmq_web_stomp;

EXPOSE 15673 15674
