//
//  AECConfigurationManager.h
//  WebServices
//
//  Created by Santosh Kumar on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACEDataManager.h"

@interface ACEConfigurationManager : ACEDataManager <NSXMLParserDelegate>

- (void)getConfugurationXML;

@end
