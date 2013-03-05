//
//  AECConfigurationManager.m
//  WebServices
//
//  Created by Santosh Kumar on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEConfigurationManager.h"
#import "Logger.h"
#import "ACELocationInfo.h"

//XML Keys.
static NSString *serverLocations_Key  = @"ServerLocations";
static NSString *ServerLocation_Key = @"ServerLocation";
static NSString *name_Key = @"name";
static NSString *URL_Key = @"URL";

@interface ACEConfigurationManager()

- (void)parseData:(NSData*)data;

@end

@implementation ACEConfigurationManager

- (void)dealloc 
{
#if !__has_feature(objc_arc)
  [super dealloc];
#endif
}

- (id)initWithDelegate:(id)_delegate;
{
    self = [super initWithDelegate:_delegate];
    if (self) { 
        self.delegate = _delegate;
        apiReqType = eConfigurationReq;
    }
    return self; 
}

- (NSString*)getAPIURL
{
    NSString *url = nil;
    
    if (kServer == isInternalServer) {
        url = kConfigurationInternalDevURL;
    }else if(kServer == isExternalServer){
        url = kConfigurationExternalDevURL;
    }else if(kServer == isProduction){
        url = kConfigurationProductionURL;
    }
   
    return url;
}

- (NSString*)getAPIType
{
    return @"GET"; 
}

- (void)generateRequest
{
    NSURL *apiURL = [[NSURL alloc] initWithString:[self getAPIURL]];
    apiRequest = [ASIHTTPRequest requestWithURL:apiURL];
    [apiRequest setDelegate:self];
    [apiRequest setValidatesSecureCertificate:NO];
    [apiRequest setRequestMethod:[self getAPIType]];
#if !__has_feature(objc_arc)
    [apiURL release];
#endif
    apiURL = nil;
}

- (void)getConfugurationXML
{
    [self generateRequest];
    [apiRequest startAsynchronous];
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSData *respData = [request responseData];
    NSString *string = [[NSString alloc] initWithData:respData encoding:NSASCIIStringEncoding];
    [Logger log:@"Response string = %@",string];
    [self parseData:respData];
}

//Parsing of XML.

- (void)parseData:(NSData*)data
{
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
	[xmlParser setDelegate:self];
	[xmlParser parse];
    xmlParser = nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 	attributes:(NSDictionary *)attributeDict 
{
	if([elementName isEqualToString:serverLocations_Key]) {
		self.responseData = [[NSMutableArray alloc] init];
    } else if([elementName isEqualToString:ServerLocation_Key]){
        ACELocationInfo *currentOBJ = [[ACELocationInfo alloc] init];
        currentOBJ.name = [attributeDict valueForKey:name_Key];
        currentOBJ.URL = [attributeDict valueForKey:URL_Key];
        [self.responseData addObject:currentOBJ];
        currentOBJ = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{  }

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{ }

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	[Logger log:@"Parser completed parsing"];
	[super requestFinished:nil];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	[Logger log:@"Error Occured while parsing"];
	
    //Base classes override this to modify error. By default it passes error to delegate.
    if ([self.delegate respondsToSelector:@selector(ACEConnectionManager:didRecieveError:)]) {
        [self.delegate ACEConnectionManager:self didRecieveError:parseError];
    }
}

@end
