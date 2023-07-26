# Fonte: https://learn.microsoft.com/en-us/azure/active-directory-domain-services/tutorial-configure-ldaps
Set-Location C:\Suporte

# Define your own DNS name used by your managed domain
$dnsName="DOMAIN"

# Get the current date to set a one-year expiration
$lifetime=Get-Date

# Create a self-signed certificate for use with Azure AD DS
New-SelfSignedCertificate -Subject *.$dnsName `
  -NotAfter $lifetime.AddDays(365) -KeyUsage DigitalSignature, KeyEncipherment `
  -Type SSLServerAuthentication -DnsName *.$dnsName, $dnsName
