# https://developers.redhat.com/blog/2020/07/23/installing-red-hat-advanced-cluster-management-acm-for-kubernetes#acm_installation_overview
# - Prepare the environment for the ACM installation.
# - Create a new OpenShift project and namespace.
# - Create an image-pull secret.
# - Install ACM and subscribe to the ACM Operator group.
# - Create the MultiClusterHub resource.
# - Verify the ACM installation.
#!/bin/bash
# Prepare the environment for the ACM installation
# Infra Nodes
oc get machinesets -n openshift-machine-api
oc patch machineset CLUSTER_NAME --type='merge' --patch='{&quot;spec&quot;: { &quot;template&quot;: { &quot;spec&quot;: { &quot;providerSpec&quot;: { &quot;value&quot;: { &quot;instanceType&quot;: &quot;m5.2xlarge&quot;}}}}}}' -n openshift-machine-api&lt;/pre&gt;
oc scale machineset CLUSTER_NAME --replicas=0 -n openshift-machine-api
oc scale machineset CLUSTER_NAME --replicas=1 -n openshift-machine-api
# Create a new OpenShift project and namespace.
#oc create namespace open-cluster-management
#oc project open-cluster-management
# Install ACM and subscribe to the ACM Operator group.
oc apply -f acm-operator.yaml
# - Create the MultiClusterHub resource.
oc apply -f multicluster-acm.yaml
oc get mch -o=jsonpath='{.items[0].status.phase}'
oc get route
