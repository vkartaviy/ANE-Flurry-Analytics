//
//  TypeConversion.h
//  GameCenterIosExtension
//
//  Created by Richard Lord on 18/06/2012.
//  Copyright (c) 2012 Stick Sports Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

@interface Flurry_TypeConversion : NSObject

- (FREResult) FREGetObject:(FREObject)object asString:(NSString**)value;
- (FREResult) FREGetString:(NSString*)string asObject:(FREObject*)asString;

@end
