### Redis scheduler errors

If you use the Redis scheduler, you may encounter the following errors under certain race conditions:

- `ERR wrong number of arguments for 'subscribe' command`
- `ERR only (P)SUBSCRIBE / (P)UNSUBSCRIBE / PING / QUIT allowed in this context`

**Workaround**: Switch to the SQL scheduler instead of the Redis scheduler.

**Affected versions**: 0.8.39/0.9.31/0.10.15