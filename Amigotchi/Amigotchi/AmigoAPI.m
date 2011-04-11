//
//  AmigoAPI.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoAPI.h"

static NSString* API_ROOT = @"http://amigotchiapi.appspot.com";
static NSString* LOGIN_ENDPOINT = @"/user/login";

@implementation AmigoAPI
@synthesize queue;

- (id)init {
    self = [super init];
    
    if (self) {
        
        if(![self queue]){
           [self setQueue:[[[ASINetworkQueue alloc] init] autorelease] ];
        }
        
    }
    return self;
}

-(void)login:(NSString*)access_token {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT, LOGIN_ENDPOINT] ];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    
    [request setPostValue:access_token forKey:@"access_token"];
    
    
    NSLog(@"adding to queue");
    [[self queue] addOperation:request];
    [[self queue] go];
}

- (void)requestDone:(ASIHTTPRequest *)request
{
    NSString *response = [request responseString];
    id parsedJson = [self parseJsonResponse:response];
    
    NSString *first_name = [parsedJson objectForKey:@"first_name"];
    if (first_name != nil){
        NSLog([NSString stringWithFormat:@"Hello %@",first_name]);
    }
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(error);
}

/**
 * parse the response data
 */
- (id)parseJsonResponse:(NSString *)responseString {
    
    SBJSON *jsonParser = [[SBJSON new] autorelease];
    
    id result = [jsonParser objectWithString:responseString];
    return result;
    
}

@end
