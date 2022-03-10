@description('parameters to get out of main module')
param tagValues object 
param location string 
param trustedIP array = []
param diskEncryptionId string
param environment string 

@description('naming of the resources')
param webSecurityName string = 'web-nsg'
param webSecRules1 string = 'web-https-rules'
param webSecRules2 string = 'web-http-rules'
param webSecRules3 string = 'web-ssh-rules'
param publicIpName string = 'publicIP2'
param nicName string = 'webnic'
param vNetWebName string = 'web-vnet'
param webVMname string = 'webvm${environment}'
param webUserName string = 'webuser${environment}'

param pubkey string 

@description('vnet configurations')
var vnetwebConfig = {
  addressSpacePrefix: '10.20.20.0/24'
  subnetName: 'subnet1'
  subnetPrefix: '10.20.20.0/24'
}

@description('configurations VM')
param webvmSize string = 'Standard_B1s'

@description('Windows version for the VM; picks a fully patched Gen2 image of this given Windows version.')
param OSVersion string = '21_10-gen2'

// find out what to fill out for requirements. 
resource webSecGroup 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: webSecurityName
  location: location
  tags: tagValues
  properties: {
    securityRules: [
      {
        name: webSecRules1
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '443'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 1000
          protocol:'Tcp'
          sourceAddressPrefix: '*'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
      }
      {
        name: webSecRules2
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '80'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 1500
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
      }
      {
        name: webSecRules3
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '22'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 2000
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourceAddressPrefixes: trustedIP
          sourcePortRange: '*'
          sourcePortRanges: []
        }
      }
    ]
  }
}

// works in admin
resource publicIPweb 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIpName
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

// works in admin
resource vnetweb 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vNetWebName
  location: location
  tags: tagValues
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetwebConfig.addressSpacePrefix
      ]
    }
    subnets: [
      {
        name: vnetwebConfig.subnetName
        properties: {
          addressPrefix: vnetwebConfig.subnetPrefix
          networkSecurityGroup: {
            id: webSecGroup.id
          }
        }
      }
    ]
  }
}

// works in admin
resource webNIC 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: nicName
  location: location
  tags: tagValues
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'AdminIpConvig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPweb.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetweb.name, vnetwebConfig.subnetName)
          }
          primary: true
          privateIPAddress: 'IPv4'
        }
      }
    ]
  }
}

// needs to be tested
resource web_VM 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: webVMname
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
      vmSize: webvmSize
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: webNIC.id
          properties: {
            deleteOption: 'Detach'
            primary: true
          }
        }
      ]
    }
    osProfile: {
      adminPassword: null
      adminUsername: webUserName
      allowExtensionOperations: true
      computerName: webVMname
      linuxConfiguration: {
        disablePasswordAuthentication: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        provisionVMAgent: true
        ssh: {
          publicKeys: [
            {
              keyData: pubkey
              path: '/home/${webUserName}/.ssh/authorized_keys'
            }
          ]
        }
      }
      secrets: []
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-impish'
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
        osType: 'Linux'
      }
    }
  }
}

@description('the output of the resources')
output vnetWebId string = vnetweb.id
output webvnetname string = vnetweb.name
output webservId string = web_VM.id
output webservname string = web_VM.name
