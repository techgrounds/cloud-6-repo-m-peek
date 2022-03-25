@description('parameters to get out of main module')
param tagValues object 
param location string 
param environment string 
param trustedIP array
@secure()
param certPassword string

@description('naming of the resources')
param publicIpName string = 'publicIP2'
param publicIpbackendName string = 'backendIP' 
param webnsgName string = 'webnsg-${environment}'
param vNetWebName string = 'web-vnet'
param webnatgateName string = 'web-natgate'
param loadbalancerName string = 'webGateway${environment}'

@description('load info from file')
param certdata string = loadFileAsBase64('../modules/secrets/certificate.p12')

@description('vnet configurations')
var vnetwebConfig = {
  addressSpacePrefix: '10.0.0.0/16'
  subnetName1: 'subnet1'
  subnetPrefix1: '10.0.1.0/24'
  subnetName2: 'backendsubnet'
  subnetPrefix2: '10.0.2.0/24'
}

resource publicIPweb 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIpName
  location: location
  tags: tagValues
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    idleTimeoutInMinutes: 4
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static' 
  }
}

resource publicIPbackend 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIpbackendName
  location: location
  tags: tagValues
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    idleTimeoutInMinutes: 4
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static' 
  }
}



resource webNSG 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: webnsgName
  location: location
  tags: tagValues
  properties: {
    securityRules: [
        {
          name: 'HTTP'
          properties: {
            access: 'Allow'
            destinationAddressPrefix: '*'
            destinationAddressPrefixes: []
            destinationPortRange: '80'
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
          name: 'HTTPS'
          properties: {
            access: 'Allow'
            destinationAddressPrefix: '*'
            destinationAddressPrefixes: []
            destinationPortRange: '443'
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
          name: 'SSH'
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
    dhcpOptions: {
      dnsServers: []
    }
    enableDdosProtection: false
    subnets: [
      {
        name: vnetwebConfig.subnetName1
        properties: {
          addressPrefix: vnetwebConfig.subnetPrefix1
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: vnetwebConfig.subnetName2
        properties: {
          addressPrefix: vnetwebConfig.subnetPrefix2
          natGateway: {
            id: webnatgate.id
          }
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}


resource webnatgate 'Microsoft.Network/natGateways@2021-05-01' = {
  name: webnatgateName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    idleTimeoutInMinutes: 4
    publicIpAddresses: [
      {
        id: publicIPbackend.id
      }
    ]
  }
}

resource loadbalancer 'Microsoft.Network/applicationGateways@2021-05-01' = {
  name: loadbalancerName
  location: location
  tags: tagValues
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
      capacity: 3
    }
    gatewayIPConfigurations: [
      {
        name: 'frontendIP'
        properties: {
          subnet: {
            id: vnetweb.properties.subnets[0].id
          }
        }
      }
    ]
    sslCertificates: [
      {
        name: 'SslCert'
        properties: {
          data: certdata
          password: certPassword
        }
      }
    ]
    authenticationCertificates: []
    frontendIPConfigurations: [
      {
        name: 'frontendIP'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPweb.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'frontendPort'
        properties: {
          port: 443
        }
      }
      {
        name: 'httpPort'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'backendPool'
        properties: {
          backendAddresses: []
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'backendSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          connectionDraining: {
            drainTimeoutInSec: 1
            enabled: false
          }
          pickHostNameFromBackendAddress: false
          requestTimeout: 30
        }
      }
    ]
    httpListeners: [
      {
        name: 'httpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', loadbalancerName, 'frontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', loadbalancerName, 'frontendPort')
          }
          protocol: 'Https'
          sslCertificate: {
            id: resourceId('Microsoft.Network/applicationGateways/sslCertificates',  loadbalancerName, 'SslCert')
          }
          hostNames: []
          requireServerNameIndication: false
        }
      }
      {
        name: 'listener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', loadbalancerName, 'frontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', loadbalancerName, 'httpPort')
          }
          protocol: 'Http'
          hostNames: []
          requireServerNameIndication: false
        }
      }
    ]
    urlPathMaps: []
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', loadbalancerName, 'httpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', loadbalancerName, 'backendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', loadbalancerName, 'backendSettings')
          }
        }
      }
      {
        name: 'rule2'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', loadbalancerName, 'listener')
          }
          redirectConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/redirectConfigurations', loadbalancerName, 'httpTOhttps')
          }
        }
      }
    ]
    probes: []
    rewriteRuleSets: []
    redirectConfigurations: [
      {
        name: 'httpTOhttps'
        properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', loadbalancerName, 'httpListener')
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
            {
              id: resourceId('Microsoft.Network/applicationGateways/requestRoutingRules', loadbalancerName, 'rule2')
            }
          ]
        }
      }
    ]
  }
}

@description('outputs of the resources')
output loadbalancerName string = loadbalancer.name
output webvnetName string = vnetweb.name
output webvnetID string = vnetweb.id
output webNSGid string = webNSG.id
