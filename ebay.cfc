<cfcomponent>
	<cffunction name="getEbayAuthToken" access="public" returnformat="JSON" description="gets auth token from db, app var, or wherever it's stored">
		
		<cfset var return_struct = {} />

		<!--- 
			This function wouldn't be required, but it's never a good idea to hard-code your keys.
			It's a good idea to store these in your DB or a file outside of your web root.
		--->

		<!--- add your eBay auth info here (available from within the eBay API test tool) --->
		<!--- https://developer.ebay.com/DevZone/build-test/test-tool/ --->
		<cfset return_struct.token = '' />
		<cfset return_struct.url = '' />
		<cfset return_struct.dev_id = '' />
		<cfset return_struct.app_id = '' />
		<cfset return_struct.cert_id = '' />

		<cfreturn return_struct />
	</cffunction>

	<cffunction name="getEbayTime" access="remote" output="true" description="gets time from eBay (test function)">
		
 		<cfset var ebay_auth = this.getEbayAuthToken() />
 		<cfset var xml_body = '' />
 		<cfset var response = '' />
 		<cfset var clean_response = '' />
		<cfset var ebay_time = '' />

		<!--- prepare the xml body (xml structure available from the eBay API test tool) --->
		<!--- https://developer.ebay.com/DevZone/build-test/test-tool/ --->
		<cfsavecontent variable="xml_body">
			<?xml version="1.0" encoding="utf-8"?>
			<GeteBayOfficialTimeRequest xmlns="urn:ebay:apis:eBLBaseComponents">
				<RequesterCredentials>
					<eBayAuthToken>#ebay_auth.token#</eBayAuthToken>
				</RequesterCredentials>
			</GeteBayOfficialTimeRequest>​
		</cfsavecontent>

		<!--- create the API call and send it off --->
		<cfhttp url="#ebay_auth.url#" method="post" result="response">
			<cfhttpparam type="header" name="X-EBAY-API-COMPATIBILITY-LEVEL" value="757" />
			<cfhttpparam type="header" name="X-EBAY-API-DEV-NAME" value="#ebay_auth.dev_id#" />
			<cfhttpparam type="header" name="X-EBAY-API-APP-NAME" value="#ebay_auth.app_id#" />
			<cfhttpparam type="header" name="X-EBAY-API-CERT-NAME" value="#ebay_auth.cert_id#" />
			<cfhttpparam type="header" name="X-EBAY-API-SITEID" value="0" />
			<cfhttpparam type="header" name="X-EBAY-API-CALL-NAME" value="GeteBayOfficialTime" />
			<cfhttpparam type="xml" value="#trim(xml_body)#" />
		</cfhttp>

		<!--- check the response --->
		<cftry>
			<!--- attempt to parse the XML --->
			<cfset clean_response = xmlParse(trim(response.Filecontent)) />
			<cfcatch type="any">
				<cfreturn {status="failure",error_detail="failed to parse eBay reponse XML"} />
			</cfcatch>
		</cftry>

		<cfset ebay_time = clean_response.GeteBayOfficialTimeResponse.Timestamp.XmlText />

		<cfreturn ebay_time />
	</cffunction>
</cfcomponent>