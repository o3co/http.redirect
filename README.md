# Simple Redirection NGINX

## Env Vars

| Var Name | Desc | Default |
| - | - | - |
| CONFIG_FILE   | Configuration template | `simple.conf.template` |
| PORT          | Listen port            | `80` |
| LISTEN_FLAG   | Listen flag of nginx   | `default_server` |
| SERVER_NAME   | Listen server name     | `_` |
| REDIRECT_FLAG | Redirect flag of nginx | `redirect` |
| REDIRECT_TO   | Base url of where redirect to | none |

## Dockerrun 

```
docker run -it -e PORT=80 -e REDIRECT_TO="https://recdirect.to" -p 80:80
```

and test on  

```
http://localhost/foo?bar=0
```

will redirect to 
```
https://redirect.to/foo?bar=0
```
