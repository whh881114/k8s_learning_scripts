local vars = import './vars.libsonnet';

local ports = [
    if "protocol" in p then
    {
        name: p.name,
        port: p.containerPort,
        targetPort: p.containerPort,
        protocol: p.protocol
    }
    else
    {
        name: p.name,
        port: p.containerPort,
        targetPort: p.containerPort,
    }
    for p in vars['container_ports']
];


[
  {
    apiVersion: "v1",
    kind: "Service",
    metadata: {
      name: if service_type == "ClusterIP" then instance['name'] else "%s-%s" % [instance['name'], std.asciiLower(service_type)],
      namespace: vars['namespace'],
      labels: {app: instance['name']},
    },
    spec: {
      selector: {app: instance['name']},
      type: "%s" % service_type,
      ports: ports
    }
  },
  for instance in vars['instances']
  for service_type in ["ClusterIP", "NodePort"]
]