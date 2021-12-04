# Secure traffic with a web application firewall (WAF)
# https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-network#secure-traffic-with-a-web-application-firewall-waf

# Baseline architecture for an Azure Kubernetes Service (AKS) cluster
# https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks

/*

VNET           SUBNET                       CIDR              HOST_MIN       HOST_MAX           HOSTS       HOSTS
                                                                                                COUNT   AVAILABLE

hub                                         10.200.0.0/24     10.200.0.1     10.200.0.254         254

               AzureFirewallSubnet          10.200.0.0/26     10.200.0.1     10.200.0.62           62          59
               GatewaySubnet                10.200.0.0/26     10.200.0.65    10.200.0.94           30           -       // availability dependent on dynamic use
               AzureBastionSubnet           10.200.0.96/27    10.200.0.97    10.200.0.126          30          27

spoke-one                                   10.240.0.0/13     10.240.0.1     10.247.255.254   524.286

              snet-cluternodes              10.240.0.0/22     10.240.0.1     10.240.3.254       1.022       1.019
              snet-cluisteringressservices  10.240.4.0/28     10.240.4.1     10.240.4.14           14          11
              snet-applicationgateways      10.240.4.16/28    10.240.4.17    10.240.4.30           14          11
*/

locals {
  location = "centralus"

  vnets = {
    "hub" = {
      name = "hub"
      cidr = "10.200.0.0/24"
      subnets = [
        { name = "AzureFirewallSubnet", cidr = "10.200.0.0/26" },
        { name = "GatewaySubnet", cidr = "10.200.0.64/27" },
        { name = "AzureBastionSubnet", cidr = "10.200.0.96/27" },
      ]
    }
    "spokeone" = {
      name = "spoke-one"
      cidr = "10.240.0.0/16"
      subnets = [
        { name = "snet-cluternodes", cidr = "10.240.0.0/22", },
        { name = "snet-cluisteringressservices", cidr = "10.240.4.0/28", },
        { name = "snet-applicationgateways", cidr = "10.240.4.16/28", },
      ]
    }
  }
}

module "shared_network_configuration" {
  source = "../../src/vnets"

  platform_instance_name = local.platform_instance_name
  vnets                  = local.vnets
  location               = local.location
}
