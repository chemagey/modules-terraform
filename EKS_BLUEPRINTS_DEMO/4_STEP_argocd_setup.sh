#!/bin/bash
echo "+++++++ Exporting ArgoCD web, you will need to accept the certificate..."
export ARGOCD_SERVER=`kubectl get svc argo-cd-argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'`
echo "The Argo CD web page is:  https://$ARGOCD_SERVER"
echo "And the password for the admin user is"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo " "