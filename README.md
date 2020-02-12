# gucamole
My deployment of Apache guacamole using docker on centos 7.6 with duo

If you want to convert the non duo guac to do swap the docker-compose and add the "extensions folder" from the guac_duo folder.
Fallow the DUO instructions in the guac_duo readme. 

Suggested versions of containers
--------------------------------
Guacamole 1.1.0 and guacd 1.1.0 currenlty runs a incompatable clipboard data type with XRDP whuch causes the XRDP server to restart. 

- guacamole/guacamole:1.0.0
- guacamole/guacd:1.0.0


Log Rotate example for containers using docker-compose
------------------------------------------------------

```python
my-app:
    image: my-app:version
    logging:
        driver: "json-file"
        options:
            max-file: "5"
            max-size: 100m
```
           
            
