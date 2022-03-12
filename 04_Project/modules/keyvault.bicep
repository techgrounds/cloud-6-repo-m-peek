@description('values from main')
param tagValue object
param location string 
param objectId string 

@description('naming of the resources')
param keyVaultName string = 'vault${uniqueString(resourceGroup().id)}'
param keyName string = 'key${uniqueString(resourceGroup().id)}'
param diskEncrypName string = 'encrypt${uniqueString(resourceGroup().id)}'
param managedIdName string = 'manId${uniqueString(resourceGroup().id)}'
param accesPoliciesName string = 'add'

@description('specify userdata')
param tenantId string = subscription().tenantId

// create keyvault resource
resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  tags: tagValue
  properties: {
    accessPolicies: [
      {
        objectId: objectId
        permissions: {
          certificates: [
            'backup'
            'create'
            'delete'
            'deleteissuers'
            'get'
            'getissuers'
            'import'
            'list'
            'listissuers'
            'managecontacts'
            'manageissuers'
            'purge'
            'recover'
            'restore'
            'setissuers'
            'update' 
          ]
          keys: [
            'backup'
            'create'
            'decrypt'
            'delete'
            'encrypt'
            'get'
            'getrotationpolicy'
            'import'
            'list'
            'purge'
            'recover'
            'release'
            'restore'
            'rotate'
            'setrotationpolicy'
            'sign'
            'unwrapKey'
            'update'
            'verify'
            'wrapKey'  
          ]
          secrets: [
            'backup'
            'delete'
            'get'
            'list'
            'purge'
            'recover'
            'restore'
            'set'  
          ]
        }
        tenantId: tenantId
      }
    ]
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enablePurgeProtection: true
    enableRbacAuthorization: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenantId
  }
}

// create key in keyvault
resource keyVaultKey 'Microsoft.KeyVault/vaults/keys@2021-11-01-preview' = {
  name: keyName
  tags: tagValue
  parent: keyVault
  properties: {
    keyOps: [
      'decrypt'
      'encrypt'
      'sign'
      'unwrapKey'
      'verify'
      'wrapKey'
    ]
    keySize: 2048
    kty:'RSA'
  }
}

// create diskencryptionset
resource diskencryptionset 'Microsoft.Compute/diskEncryptionSets@2021-08-01' = {
  name: diskEncrypName
  location: location
  tags: tagValue
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    activeKey: {
      sourceVault: {
        id: keyVault.id
      }
      keyUrl: keyVaultKey.properties.keyUriWithVersion
    }
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    rotationToLatestKeyVersionEnabled: true
  }
}

// create user assigned identity
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdName
  location: location
  tags: tagValue
  dependsOn: [
    keyVault
  ]
}

// create vault accesspolicies for diskencryptionset and managed identity
resource accessPolicies 'Microsoft.KeyVault/vaults/accessPolicies@2021-11-01-preview' = {
  name: accesPoliciesName
  parent: keyVault
  properties: {
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: diskencryptionset.identity.principalId
        permissions: {
          keys: [
            'get'
            'list'
            'unwrapKey'
            'wrapKey'
          ]
          secrets: []
          certificates: []
        }
      }
      {
        tenantId: tenantId
        objectId: managedIdentity.properties.principalId
        permissions: {
          keys: [
            'get'
            'list'
            'unwrapKey'
            'wrapKey'  
          ]
          secrets: []
          certificates: []
        }
      }
    ] 
  }
}

@description('output of the resources')
output keyvaultUri string = keyVault.properties.vaultUri
output keyname string = keyVaultKey.name
output diskencryptionId string = diskencryptionset.id
output managedId string = managedIdentity.id
