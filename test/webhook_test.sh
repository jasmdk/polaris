#!/bin/bash
kubectl apply &> /dev/null -f https://github.com/FairwindsOps/polaris/releases/latest/download/webhook.yaml

kubectl apply &> /dev/null -f test/correctconfig.yaml
if [ $? -eq 0 ]; then
    VAR1="pass"
    echo pass 
else
    echo "Test Failed: Polaris prevented a deployment with no configuration issues." 
fi

kubectl apply -f test/incorrectconfig.yaml
if [ $? -ne 0 ]; then
    VAR2="pass"
    echo pass 
else
    echo "Test Failed: Polaris should have prevented this deployment due to configuration problems."
fi

if [ "$VAR1" == "pass" -a "$VAR2" == "pass" ]; then
    echo "Tests Passed."
else
    echo "Tests Failed"
    exit 1
fi
