@description('parameters to get out of main module')
param location string 
param tagValues object 
param trustedIP array = []
param diskEncryptionId string
param environment string 

@description('naming of resources')
param adminnsgName string = 'admin-nsg'
param adminSecRules string = 'admin-nsg-rules'
param adminPublicIpName string = 'publicIP1'
param adminnicName string = 'adminnic'
param vNetAdminName string = 'admin-vnet'
param adminvmName string = 'adminvm'
param adminUserName string = 'adminuser-${environment}'

@description('vnet configurations')
var vnetadminConfig = {
  addressSpacePrefix: '10.10.10.0/24'
  subnetName: 'subnet1'
  subnetPrefix: '10.10.10.0/24'
}

@description('configurations VM')
param adminvmSize string = 'Standard_B1s'

@description('password for the admin VM')
@secure()
param adminPassword string

param OSVersion string = '2022-datacenter-azure-edition'


// works, add ssh rule
resource adminNSG 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: adminnsgName
  location: location
  tags: tagValues
  properties: {
    securityRules: [
      {
        name: adminSecRules
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '3389'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 1000
          protocol:'Tcp'
          sourceAddressPrefix: '*'
          sourceAddressPrefixes: trustedIP
          sourcePortRange: '*'
          sourcePortRanges: []
        }
      }
    ]
  }
}

// required properties filled out
resource publicIPadmin 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: adminPublicIpName
  location: location
  tags: tagValues
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}

// required properties filled out
resource vnetadmin 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vNetAdminName
  location: location
  tags: tagValues
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetadminConfig.addressSpacePrefix
      ]
    }
    subnets: [
      {
        name: vnetadminConfig.subnetName
        properties: {
          addressPrefix: vnetadminConfig.subnetPrefix
          networkSecurityGroup: {
            id: adminNSG.id
          }
        }
      }
    ]
  }
}

// requiredproperties filled out
resource adminNIC 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: adminnicName
  location: location
  tags: tagValues
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'AdminIpConfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPadmin.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetadmin.name, vnetadminConfig.subnetName)
          }
          primary: true
          privateIPAddress: 'IPv4'
        }
      }
    ]
  }
}

// required properties filled out
resource admin_vm 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: adminvmName
  location: location
  tags: tagValues
  zones: [
    '1'
  ]
  properties: {
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
    hardwareProfile: {
      vmSize: adminvmSize
    }
    licenseType: 'Windows_Server'
    networkProfile: {
      networkInterfaces: [
        {
          id: adminNIC.id
          properties: {
            deleteOption: 'Detach'
            primary: true
          }
        }
      ]
    }
    osProfile: {
      adminPassword: adminPassword
      adminUsername: adminUserName
      allowExtensionOperations: true
      computerName: adminvmName
      secrets: []
      windowsConfiguration: {
        enableAutomaticUpdates: true
        patchSettings: {
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
          patchMode: 'AutomaticByOS'
        }
      }
    }
      storageProfile: {
        imageReference: {
        offer: 'WindowsServer'
        publisher: 'MicrosoftWindowsServer'
        sku: OSVersion
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        deleteOption: 'Delete'
        managedDisk: {
          diskEncryptionSet: {
            id: diskEncryptionId
          }
          storageAccountType: 'Standard_LRS'
        }
        osType: 'Windows'
      }
    }
  }
}

@description('the output of the resources')
output vnetAdminiD string = vnetadmin.id
output adminvnetname string = vnetadmin.name
output adminservId string = admin_vm.id
output adminservname string = admin_vm.name

