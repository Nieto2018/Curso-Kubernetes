La prueba consiste en como un balanceador montado en un cluster en K3D puede exponer los servicios de distintos namespace a través de DNS.

Todos los objetos son replicados en dos namespaces: dev y prod. Lo más destacado de la prueba es que cada namespace tiene su respectivo Ingress con sus paths y son automáticamente reconocido sin tener que tocar nada de ninguna otra parte de kubernetes, K3D o el namespace default.

https://k3d.io/usage/guides/exposing_services/
