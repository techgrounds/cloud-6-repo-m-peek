/* module needs a lot of work, has not been tested for obious reasons
this will launch:
- recovery vault
- backuppolicies
- protected items (adminserver & webserver)
*/

targetScope = 'resourceGroup'

@description('parameters to get out of main file')
param location string
param tagValues object

@description('naming of the resources')
param recoveryvaultName string = 'recvault${uniqueString(resourceGroup().id)}'
param backupPoliciesName string = 'bPolicy${uniqueString(resourceGroup().id)}'
param protectedName1 string = 'prtAdmin${uniqueString(resourceGroup().id)}'
param protectedName2 string = 'prtWeb${uniqueString(resourceGroup().id)}'

resource recoveryVault 'Microsoft.RecoveryServices/vaults@2021-11-01-preview' = {
  name: recoveryvaultName
  location: location
  tags: tagValues
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource backupPolicies 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-12-01' = {
  parent: recoveryVault
  name: backupPoliciesName
  location: location
  tags: tagValues
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'LogSchedulePolicy'
    }
  }
}

resource protectedItems1 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2021-12-01' = {
  parent: recoveryVault
  name: protectedName1
  location: location
  tags: tagValues
  properties: {
    protectedItemType: 'Microsoft.Compute/virtualMachines'
  }
}


resource protectedItems2 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2021-12-01' = {
  parent: 
  name: protectedName2
  location: location
  tags: tagValues
  properties: {
    protectedItemType: 'Microsoft.Compute/virtualMachines'
  }
}
