#
# NOTE: THIS DOCKERFILE IS IDENTICAL TO `rabbitmq:3.8.0-management` rabbitmq/3.8/ubuntu/management/Dockerfile which is the base used by dokku
#
# THE IMAGE IS MODIFIED TO ADD ENABLE PLUGINS: RABBITMQ_STOMP AND RABBITMQ_WEB_STOMP.
# FROM rabbitmq:3.8.0-management
# 

FROM rabbitmq:3.8

RUN set eux; \
	rabbitmq-plugins enable --offline rabbitmq_management; \
	rabbitmq-plugins enable rabbitmq_stomp; \
	rabbitmq-plugins enable rabbitmq_web_stomp; \
# make sure the metrics collector is re-enabled (disabled in the base image for Prometheus-style metrics by default)
	rm -f /etc/rabbitmq/conf.d/management_agent.disable_metrics_collector.conf; \
# extract "rabbitmqadmin" from inside the "rabbitmq_management-X.Y.Z.ez" plugin zipfile
# see https://github.com/docker-library/rabbitmq/issues/207
	erl -noinput -eval ' \
		{ ok, AdminBin } = zip:foldl(fun(FileInArchive, GetInfo, GetBin, Acc) -> \
			case Acc of \
				"" -> \
					case lists:suffix("/rabbitmqadmin", FileInArchive) of \
						true -> GetBin(); \
						false -> Acc \
					end; \
				_ -> Acc \
			end \
		end, "", init:get_plain_arguments()), \
		io:format("~s", [ AdminBin ]), \
		init:stop(). \
	' -- /plugins/rabbitmq_management-*.ez > /usr/local/bin/rabbitmqadmin; \
	[ -s /usr/local/bin/rabbitmqadmin ]; \
	chmod +x /usr/local/bin/rabbitmqadmin; \
	apt-get update; \
	apt-get install -y --no-install-recommends python3; \
	rm -rf /var/lib/apt/lists/*; \
	rabbitmqadmin --version

EXPOSE 15671 15672 15673 15674
