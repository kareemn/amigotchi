//
//  AmigoAPI.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoAPI.h"
#import "JSON.h"

static NSString* API_ROOT = @"http://amigotchiapi.appspot.com";
static NSString* LOGIN_ENDPOINT = @"/user/login";

@implementation AmigoAPI
@synthesize queue = queue_, user = user_;

- (id)init {
    self = [super init];
    
    if (self) {
        
        if(![self queue]){
           [self setQueue:[[[ASINetworkQueue alloc] init] autorelease] ];
        }
        
        [self setUser:[[AmigoUser alloc] init] ];
        
    }
    return self;
}

-(void)login:(NSString*)access_token {
    
    [[self user] setAccess_token:access_token];
    
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
    
    NSLog(@"%@", [parsedJson description]);
    
    NSString *first_name = [parsedJson objectForKey:@"first_name"];
    NSString *profile_id = [parsedJson objectForKey:@"id"];
    
    if (first_name != nil && profile_id != nil){
        
        [[self user] setName:first_name];
        [[self user] setProfile_id:profile_id];
        
        
        NSLog(@"%@", [[self user] description]);
    }
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    [[self user] setAccess_token:[NSString stringWithFormat:@"0"]];
    NSError *error = [request error];
    NSLog(@"%@", error);
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
