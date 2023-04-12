# https://diagrams.mingrammer.com/docs/getting-started/examples
from diagrams import Diagram
from diagrams.onprem.compute import Server
from diagrams.onprem.network import Nginx
from diagrams.onprem.database import Postgresql


with Diagram("LB Testing", show=False, direction="TB"):

    Nginx("Load Balancer") >> [Server("WEB Node 1"),
                               Server("WEB Node 2"),
                               Server("WEB Node 3")] >> Postgresql("DB")
