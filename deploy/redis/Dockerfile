FROM redis
COPY redis.conf /usr/local/etc/redis/redis.conf

COPY liveness /usr/local/etc/redis/liveness
COPY health /usr/local/etc/redis/health

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

EXPOSE 6379