local vars = import '../vars.libsonnet';

local services = [{name: "consul-server", type: "ClusterIP"}, {name: "consul-server-nodeport", type: "NodePort"}];

local ports = [
    {name: p.name, port: p.port, targetPort: p.containerPort}
    for p in vars['server_container_ports']
];


[
  {
    apiVersion: "v1",
    kind: "Service",
    metadata: {
      name: "%s" % service.name,
      namespace: vars['namespace'],
      labels: {name: "consul-server"},
    },
    spec: {
      selector: {app: "consul-server"},
      type: "%s" % service.type,
      ports: ports
    }
  }

  for service in services
]