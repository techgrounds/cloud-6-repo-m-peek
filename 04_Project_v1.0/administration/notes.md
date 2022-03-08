## P.O meet 15/2/22

Only implement what the architect designed.
- the basic outline is what the arichtect designed 
- make the minimum vial product

- create small itterations to create the minimal requierd vial product
    - parameters en variables

- architecture has only forgot the things that need to be defined 

- webserver recommendation
- management server is windows

- make different resourcegroups

- boodstrapscript meegeven, webapp heeft nodig. custom data in boodstrapscript, vm moet starten met dat script. 

V1.1 is about improving the infrastructure. 

- suggestion -> grs or gzrs

## Scope functions for bicep
- managementgroup
    - returns an object with properties from the management group in current deployment.
    - can only be used on a management group deployments. It returns the current management group for the deployment operation. 
- resourcegroup
    - Returns an object that represents the current resource group.
    - One usage is for setting the scope on a module or extension resource type. The other usage is for getting details about the current resource group.  
- subscription
    - Returns details about the subscription for the current deployment.
    - One usage is for setting the scope on a module or extension resource type. The other usage is for getting details about the current subscription.
- tenant 
    - Returns an object used for setting the scope to the tenant.
    - can be used with any deployment scope. It always returns the current tenant. You can use this function to set the scope for a resource, or to get properties for the current tenant.