.PHONY: deploy-infra
deploy-infra:
	helm repo add jetstack https://charts.jetstack.io --force-update
	helm upgrade -i -n cert-manager cert-manager jetstack/cert-manager --set installCRDs=true --wait --create-namespace
	helm upgrade -i -n cert-manager trust-manager jetstack/trust-manager --wait
