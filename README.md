# Using trust-manager

This is a simple project showing various ways to use [trust-manager](https://github.com/cert-manager/trust-manager)
to control trust anchors in a Kubernetes application.

Since we have many Java applications in our clusters, I've started with some alternative approaches for transparently
manipulating the Java truststore.

## Organization of this repo

The [deploy directory](./deploy) contains kustomizations to prepare our environment for the tests:

* Configuration of cert-manager and trust-manager: create a cluster-internal root CA and configure trust-manager
  to distribute trust to this CA throughout the cluster.
* A test-server that provides an endpoint for testing, with a certificate issued by the internal root CA.
* A simple Java test application (SSLPoke), inspired by <https://confluence.atlassian.com/download/attachments/117455/SSLPoke.java>,
  to test/verify trust anchor configuration from Java. The application is provisioned as source code into a configmap.
  The source code is compiled before running the application inside the client container.

The [usages directory](./usages) contains kustomizations to create/delete jobs for various test cases.

## Running the tests/usages

First you need a Kubernetes cluster, probably an ephemeral one like minikube, kind or ks (bootstrapped with k3d).

Then run `make deploy` to set up what's required in your cluster to run the tests.

Finally run `make create-jobs` to create individual jobs for all usage alternatives. Since jobs are more or less immutable,
you should probably delete jobs before attempting to re-run anything. There is a make target for that: `make delete-jobs`.