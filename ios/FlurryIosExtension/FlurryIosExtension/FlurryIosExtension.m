//
//  FlurryIosExtension.m
//  FlurryIosExtension
//
//  Created by Richard Lord on 08/12/2011.
//  Copyright (c) 2011 Stick Sports Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "FlurryAnalytics.h"
#import "Flurry_TypeConversion.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

Flurry_TypeConversion* typeConverter;

DEFINE_ANE_FUNCTION( flurry_setAppVersion )
{
    NSString* version;
    if( [typeConverter FREGetObject:argv[0] asString:&version ] == FRE_OK )
    {
        [FlurryAnalytics setAppVersion:version];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_getFlurryAgentVersion )
{
    NSString* version = [FlurryAnalytics getFlurryAgentVersion];
    FREObject result;
    if ( [typeConverter FREGetString:version asObject:&result ] == FRE_OK )
    {
        return result;
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_setSessionContinueSeconds )
{
    int32_t value = 0;
    if (FREGetObjectAsInt32( argv[0], &value ) == FRE_OK )
    {
        [FlurryAnalytics setSessionContinueSeconds:value];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_setSecureTransportEnabled )
{
    uint32_t value = 0;
    if (FREGetObjectAsBool( argv[0], &value ) == FRE_OK )
    {
        if( value == 0 )
        {
            [FlurryAnalytics setSecureTransportEnabled:NO];
        }
        else
        {
            [FlurryAnalytics setSecureTransportEnabled:YES];
        }
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_startSession )
{
    NSString* sessionId;
    if( [typeConverter FREGetObject:argv[0] asString:&sessionId ] == FRE_OK )
    {
        [FlurryAnalytics startSession:sessionId];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_endSession )
{
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_logEvent )
{
    NSString* event;
    if( [typeConverter FREGetObject:argv[0] asString:&event ] != FRE_OK ) return NULL;
    
    if( argc == 2 )
    {
        FREObject array = argv[1];
        uint32_t length = 0;
        if( FREGetArrayLength( array, &length ) != FRE_OK ) return NULL;
        uint32_t count = length >> 1;
        if( count > 0 )
        {
            NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithCapacity:count];
            uint32_t i;
            NSString* key;
            NSString* value;
            FREObject fo;
            
            for( i = 0; i < count; ++i )
            {
                if( FREGetArrayElementAt( array, i * 2, &fo ) != FRE_OK ) continue;
                if( [typeConverter FREGetObject:fo asString:&key ] != FRE_OK ) continue;
                
                if( FREGetArrayElementAt( array, i * 2 + 1, &fo ) != FRE_OK ) continue;
                if( [typeConverter FREGetObject:fo asString:&value ] != FRE_OK ) continue;
                
                [parameters setValue:value forKey:key];
            }
            
            [FlurryAnalytics logEvent:event withParameters:parameters];
        }
        else
        {
            [FlurryAnalytics logEvent:event];
        }
    }
    else
    {
        [FlurryAnalytics logEvent:event];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_logError )
{
    NSString* errorId;
    if( [typeConverter FREGetObject:argv[0] asString:&errorId ] != FRE_OK ) return NULL;

    NSString* message;
    if( [typeConverter FREGetObject:argv[1] asString:&message ] != FRE_OK ) return NULL;
    
    [FlurryAnalytics logError:errorId message:message error:nil];
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_startTimedEvent )
{
    NSString* event;
    if( [typeConverter FREGetObject:argv[0] asString:&event ] != FRE_OK ) return NULL;

    if( argc == 2 )
    {
        FREObject array = argv[1];
        uint32_t length = 0;
        if( FREGetArrayLength( array, &length ) != FRE_OK ) return NULL;
        uint32_t count = length >> 1;
        if( count > 0 )
        {
            NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithCapacity:count];
            uint32_t i;
            NSString* key;
            NSString* value;
            
            FREObject fo;
            
            for( i = 0; i < count; ++i )
            {
                if( FREGetArrayElementAt( array, i * 2, &fo ) != FRE_OK ) continue;
                if( [typeConverter FREGetObject:fo asString:&key ] != FRE_OK ) continue;
                
                if( FREGetArrayElementAt( array, i * 2 + 1, &fo ) != FRE_OK ) continue;
                if( [typeConverter FREGetObject:fo asString:&value ] != FRE_OK ) continue;
                
                [parameters setValue:value forKey:key];
            }
            
            [FlurryAnalytics logEvent:event withParameters:parameters timed:YES];
        }
        else
        {
            [FlurryAnalytics logEvent:event timed:YES];
        }
    }
    else
    {
        [FlurryAnalytics logEvent:event timed:YES];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_endTimedEvent )
{
    NSString* event;
    if( [typeConverter FREGetObject:argv[0] asString:&event ] != FRE_OK ) return NULL;
    
    if( argc == 2 )
    {
        FREObject array = argv[1];
        uint32_t length = 0;
        if( FREGetArrayLength( array, &length ) != FRE_OK ) return NULL;
        uint32_t count = length >> 1;
        if( count > 0 )
        {
            NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithCapacity:count];
            uint32_t i;
            NSString* key;
            NSString* value;
            
            FREObject fo;
            
            for( i = 0; i < count; ++i )
            {
                if( FREGetArrayElementAt( array, i * 2, &fo ) != FRE_OK ) continue;
                if( [typeConverter FREGetObject:fo asString:&key ] != FRE_OK ) continue;
                
                if( FREGetArrayElementAt( array, i * 2 + 1, &fo ) != FRE_OK ) continue;
                if( [typeConverter FREGetObject:fo asString:&value ] != FRE_OK ) continue;
                
                [parameters setValue:value forKey:key];
            }
            
            [FlurryAnalytics endTimedEvent:event withParameters:parameters];
        }
        else
        {
            [FlurryAnalytics endTimedEvent:event withParameters:Nil];
        }
    }
    else
    {
        [FlurryAnalytics endTimedEvent:event withParameters:Nil];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_setUserId )
{
    NSString* userId;
    if( [typeConverter FREGetObject:argv[0] asString:&userId ] == FRE_OK )
    {
        [FlurryAnalytics setUserID:userId];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_setUserAge )
{
    int32_t value = 0;
    if (FREGetObjectAsInt32( argv[0], &value ) == FRE_OK )
    {
        [FlurryAnalytics setAge:value];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_setUserGender )
{
    NSString* userGender;
    if( [typeConverter FREGetObject:argv[0] asString:&userGender ] == FRE_OK )
    {
        [FlurryAnalytics setGender:userGender];
    }
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_setLocation )
{
    // latitude : Number, longitude : Number, horizontalAccuracy : Number, verticalAccuracy : Number
    double latitude;
    double longitude;
    double horizontalAccuracy;
    double verticalAccuracy;
    
    if( FREGetObjectAsDouble( argv[0], &latitude ) != FRE_OK ) return NULL;
    if( FREGetObjectAsDouble( argv[0], &longitude ) != FRE_OK ) return NULL;
    if( FREGetObjectAsDouble( argv[0], &horizontalAccuracy ) != FRE_OK ) return NULL;
    if( FREGetObjectAsDouble( argv[0], &verticalAccuracy ) != FRE_OK ) return NULL;
        
    [FlurryAnalytics setLatitude:latitude longitude:longitude horizontalAccuracy:horizontalAccuracy verticalAccuracy:verticalAccuracy];
    return NULL;
}

DEFINE_ANE_FUNCTION( flurry_setEventLoggingEnabled )
{
    uint32_t value = 0;
    if (FREGetObjectAsBool( argv[0], &value ) == FRE_OK )
    {
        if( value == 0 )
        {
            [FlurryAnalytics setEventLoggingEnabled:NO];
        }
        else
        {
            [FlurryAnalytics setEventLoggingEnabled:YES];
        }
    }
    return NULL;
}

void FlurryContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    static FRENamedFunction functionMap[] = {
        MAP_FUNCTION( flurry_setAppVersion, NULL ),
        MAP_FUNCTION( flurry_getFlurryAgentVersion, NULL ),
        MAP_FUNCTION( flurry_setSessionContinueSeconds, NULL ),
        MAP_FUNCTION( flurry_setSecureTransportEnabled, NULL ),
        MAP_FUNCTION( flurry_startSession, NULL ),
        MAP_FUNCTION( flurry_endSession, NULL ),
        MAP_FUNCTION( flurry_logEvent, NULL ),
        MAP_FUNCTION( flurry_logError, NULL ),
        MAP_FUNCTION( flurry_startTimedEvent, NULL ),
        MAP_FUNCTION( flurry_endTimedEvent, NULL ),
        MAP_FUNCTION( flurry_setUserId, NULL ),
        MAP_FUNCTION( flurry_setUserAge, NULL ),
        MAP_FUNCTION( flurry_setUserGender, NULL ),
        MAP_FUNCTION( flurry_setLocation, NULL ),
        MAP_FUNCTION( flurry_setEventLoggingEnabled, NULL )
    };
    
	*numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
	*functionsToSet = functionMap;
    
    typeConverter = [[Flurry_TypeConversion alloc] init];
}

void FlurryContextFinalizer( FREContext ctx )
{
	return;
}

void FlurryExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{ 
    extDataToSet = NULL;  // This example does not use any extension data. 
    *ctxInitializerToSet = &FlurryContextInitializer; 
    *ctxFinalizerToSet = &FlurryContextFinalizer; 
}

void FlurryExtensionFinalizer()
{
    return;
}
