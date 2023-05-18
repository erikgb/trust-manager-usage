.PHONY: deploy-infra
deploy-infra:
	helm repo add jetstack https://charts.jetstack.io --force-update
	helm upgrade -i -n cert-manager cert-manager jetstack/cert-manager --set installCRDs=true --wait --create-namespace
	# TODO: Using beta version for now to get access to trust-manager JKS feature
	helm upgrade -i -n cert-manager trust-manager jetstack/trust-manager --version 0.5.0-beta.1 --wait
	kubectl apply -k deploy/infra/
