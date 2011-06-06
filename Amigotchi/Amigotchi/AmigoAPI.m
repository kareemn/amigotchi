//
//  AmigoAPI.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoAPI.h"
#import "JSON.h"
#import "AmigoConfig.h"

static NSString* API_ROOT = @"http://amigotchiapi.appspot.com";
static NSString* LOGIN_ENDPOINT = @"/user/login";
static NSString* CHECKIN_ENDPOINT = @"/checkin";
static NSString* NEARBY_ENDPOINT = @"/nearby";
static NSString* PETLOAD_ENDPOINT = @"/pet/load";
static NSString* PETSAVE_ENDPOINT = @"/pet/save";
static NSString* PETFEED_ENDPOINT = @"/pet/feed";
static NSString* PETCLEAN_ENDPOINT = @"/pet/clean";
static NSString* PETHAPPY_ENDPOINT = @"/pet/happy";



@implementation AmigoAPI
@synthesize queue = queue_, user = user_, locdelegate = locdelegate_;
@synthesize facebook = facebook_;
@synthesize nearbyDelegate = nearbyDelegate_;
@synthesize checkintable = checkintable_;
@synthesize mapViewController = mapViewController_;
@synthesize postCheckinDelegate = postCheckinDelegate_;
@synthesize pet = pet_;
@synthesize facebookCheckinEnabled;


- (id)init {
    self = [super init];
    
    if (self) {
        
        if(![self queue]){
           [self setQueue:[[[ASINetworkQueue alloc] init] autorelease] ];
        }
        
        [self setUser:[[[AmigoUser alloc] init] autorelease]  ];
        [self setLocdelegate:[[[AmigoLocationDelegate alloc] init] autorelease]  ];
        [self setFacebook: [ [[Facebook alloc] init] autorelease]];
        [self setNearbyDelegate:[[[NearbyPlacesRequestResult alloc] initializeWithDelegate:self] autorelease]];
        [self setPostCheckinDelegate:[[[PostCheckinRequestResult alloc] initializeWithDelegate:self] autorelease]];
        facebookCheckinEnabled = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(apiNotification:) name:AMIGOAPINOTIFICATION object:nil];
        
               
    }
    return self;
}

-(void)login:(NSString*)access_token {
    
    [[self user] setAccess_token:access_token];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT, LOGIN_ENDPOINT] ];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(loginRequestDone:)];
    [request setDidFailSelector:@selector(loginRequestWentWrong:)];
    
    [request setPostValue:access_token forKey:@"access_token"];
    
    
    NSLog(@"adding to queue");
    [[self queue] addOperation:request];
    [[self queue] go];
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"loggedin"]];
    
    
    [self.locdelegate.locManager startUpdatingLocation];
}

- (void)loginRequestDone:(ASIHTTPRequest *)request
{
    NSString *response = [request responseString];
    id parsedJson = [self parseJsonResponse:response];
    
    NSLog(@"%@", response);
    
    NSString *first_name = [parsedJson objectForKey:@"first_name"];
    NSString *profile_id = [parsedJson objectForKey:@"id"];
    
    if (first_name != nil && profile_id != nil){
        
        [[self user] setName:first_name];
        [[self user] setProfile_id:profile_id];
        
        
        NSLog(@"%@", [[self user] description]);
    }
    
}

- (void)loginRequestWentWrong:(ASIHTTPRequest *)request
{
    [[self user] setAccess_token:[NSString stringWithFormat:@"0"]];
    NSError *error = [request error];
    NSLog(@"%@", error);
}




-(void)petLoad {
    
    [[self user] setAccess_token:self.user.access_token];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT, PETLOAD_ENDPOINT] ];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(petLoadDone:)];
    [request setDidFailSelector:@selector(petLoadWentWrong:)];
    
    [request setPostValue:self.user.access_token forKey:@"access_token"];
    
    
    NSLog(@"adding to queue");
    [[self queue] addOperation:request];
    [[self queue] go];
    
    //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"loggedin"]];
    
}

- (void)petLoadDone:(ASIHTTPRequest *)request
{
    NSLog(@"petLoadDone");
    NSString *response = [request responseString];
    NSDictionary *parsedJson = [self parseJsonResponse:response];
    NSLog(@"response:: %@", response);
    
    
    [ self performSelectorOnMainThread:@selector(petLoadState:) withObject:parsedJson waitUntilDone:NO] ;
    
}

- (void)petLoadState:(NSDictionary *)state{
    [state retain];
   [self.pet restoreState:state];
    [state release];
}

- (void)petLoadWentWrong:(ASIHTTPRequest *)request
{
    
    NSString *response = [request responseString];
    NSLog(@"petLoadWentWrong");
    
    NSLog(@"%@", response);
}


-(void)petFeed {
    
    [[self user] setAccess_token:self.user.access_token];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT, PETFEED_ENDPOINT] ];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(petFeedDone:)];
    [request setDidFailSelector:@selector(petFeedWentWrong:)];
    
    [request setPostValue:self.user.access_token forKey:@"access_token"];
    
    
    NSLog(@"adding to queue");
    [[self queue] addOperation:request];
    [[self queue] go];
    
    //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"loggedin"]];
    
}

- (void)petFeedDone:(ASIHTTPRequest *)request
{
    NSLog(@"petFeedDone");
    NSString *response = [request responseString];
    NSDictionary *parsedJson = [self parseJsonResponse:response];
    NSLog(@"response:: %@", response);
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"feed" userInfo:parsedJson]];
    
}

- (void)petFeedWentWrong:(ASIHTTPRequest *)request
{
    
    NSString *response = [request responseString];
    NSLog(@"petFeedWentWrong");
    
    NSLog(@"%@", response);
}

-(void)petClean {
    
    [[self user] setAccess_token:self.user.access_token];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT, PETCLEAN_ENDPOINT] ];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(petCleanDone:)];
    [request setDidFailSelector:@selector(petCleanWentWrong:)];
    
    [request setPostValue:self.user.access_token forKey:@"access_token"];
    
    
    NSLog(@"adding to queue");
    [[self queue] addOperation:request];
    [[self queue] go];
    
    //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"loggedin"]];
    
}

- (void)petCleanDone:(ASIHTTPRequest *)request
{
    NSLog(@"petCleanDone");
    NSString *response = [request responseString];
    NSDictionary *parsedJson = [self parseJsonResponse:response];
    NSLog(@"response:: %@", response);
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"toilet" userInfo:parsedJson]];
    
}

- (void)petCleanWentWrong:(ASIHTTPRequest *)request
{
    
    NSString *response = [request responseString];
    NSLog(@"petCleanWentWrong");
    
    NSLog(@"%@", response);
}

-(void)petHappy {
    
    [[self user] setAccess_token:self.user.access_token];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT, PETHAPPY_ENDPOINT] ];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(petHappyDone:)];
    [request setDidFailSelector:@selector(petHappyWentWrong:)];
    
    [request setPostValue:self.user.access_token forKey:@"access_token"];
    
    
    NSLog(@"adding to queue");
    [[self queue] addOperation:request];
    [[self queue] go];
    
    //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"loggedin"]];
    
}

- (void)petHappyDone:(ASIHTTPRequest *)request
{
    NSLog(@"petHappyDone");
    NSString *response = [request responseString];
    NSDictionary *parsedJson = [self parseJsonResponse:response];
    NSLog(@"response:: %@", response);
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"happy" userInfo:parsedJson]];
    
}

- (void)petHappyWentWrong:(ASIHTTPRequest *)request
{
    
    NSString *response = [request responseString];
    NSLog(@"petHappyWentWrong");
    
    NSLog(@"%@", response);
}


-(void)updateNearbyPlaces{
    //&center=lat,long&distance=1000
    
    NSString *locString  = [NSString stringWithFormat:@"%f,%f", self.locdelegate.currLoc.coordinate.latitude, self.locdelegate.currLoc.coordinate.longitude];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"place",@"type",
								   locString,@"center",
								   @"1000",@"distance", // In Meters (1000m = 0.62mi)
								   nil];
    [self.facebook requestWithGraphPath:@"search" andParams: params andDelegate:self.nearbyDelegate];
    
    /*
    NSLog(@"getCheckinList AmigoUser::%@", [self user]);
    NSString *urlString = [NSString stringWithFormat:@"%@%@&access_token=%@", GRAPH_ROOT, CHECKINLIST_ENDPOINT, self.user.access_token ];
    
    NSLog(@"urlString:: %@", urlString);
    
    
    NSURL *url = [NSURL URLWithString:urlString ];
    NSLog(@"getCheckinList url formed:%@", [url description]);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(checkinListRequestDone:)];
    [request setDidFailSelector:@selector(checkinListRequestWentWrong:)];
    
    
    NSLog(@"adding to queue");
    [[self queue] addOperation:request];
    [[self queue] go];
     */
}



/**
 * parse the response data
 */
- (id)parseJsonResponse:(NSString *)responseString {
    
    SBJSON *jsonParser = [[SBJSON new] autorelease];
    
    id result = [jsonParser objectWithString:responseString];
    return result;
    
}

- (void) nearbyPlacesRequestCompletedWithPlaces:(NSArray *)placesArray{
    NSLog(@"HERRRREEEE");
    NSLog(@"hey:: %@", [placesArray description]);
    
    if (self.checkintable != nil){
       self.checkintable.placesArray = placesArray;
    }
    
    
}
- (void) nearbyPlacesRequestFailed{
    NSLog(@"nearbyPlacesRequestFailed");
    
    
}


-(void)apiNotification:(NSNotification *)notification{
    
    // NSLog([[notification userInfo] description]);
    //NSLog([[notification object] description]);
    //NSLog(@"inputFromView:: received %@.\n", [notification object]);
    
    NSString *theobj = [notification object];
    
    if([theobj isEqualToString:@"updateNearbyPlaces"])
    {
        [self updateNearbyPlaces];
        
    }
    
}

-(void) checkin: (AmigoCheckin *)c{
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT, CHECKIN_ENDPOINT] ];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(checkinRequestDone:)];
    [request setDidFailSelector:@selector(checkinRequestWentWrong:)];
    
    [request setPostValue:self.user.access_token forKey:@"access_token"];
    [request setPostValue:c.place_id forKey:@"place_id"];
    [request setPostValue:c.title forKey:@"title"];
    [request setPostValue:c.lat forKey:@"lat"];
    [request setPostValue:c.lon forKey:@"lon"];
    
    
    NSLog(@"adding to queue");
    [[self queue] addOperation:request];
    [[self queue] go];
    
    if ( facebookCheckinEnabled ){
       [self postCheckinToFacebook:c];
    }
    

}


- (void)checkinRequestDone:(ASIHTTPRequest *)request
{
    NSString *response = [request responseString];
    NSLog(@"checkinRequestDone %@", response);
    
    NSDictionary *parsedJson = [self parseJsonResponse:response];
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"checkedin" userInfo:parsedJson]];
    
}

- (void)checkinRequestWentWrong:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"checkin error: %@", error);
}



-(void) getNearbyCheckinsForLat: (NSString *)lat andLon:(NSString *)lon{
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT, NEARBY_ENDPOINT] ];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(nearbyRequestDone:)];
    [request setDidFailSelector:@selector(nearbyRequestWentWrong:)];
    
    [request setPostValue:self.user.access_token forKey:@"access_token"];
    [request setPostValue:lat forKey:@"lat"];
    [request setPostValue:lon forKey:@"lon"];
    
    
    NSLog(@"adding to queue");
    [[self queue] addOperation:request];
    [[self queue] go];
    
    
}

- (void)nearbyRequestDone:(ASIHTTPRequest *)request
{
    NSString *response = [request responseString];
    NSArray *parsedJson = [self parseJsonResponse:response];
    
    [self.mapViewController drawCheckins:parsedJson];
    
    NSLog(@"nearbyRequestDone %@", response);
    
}

- (void)nearbyRequestWentWrong:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"nearby error: %@", error);
}

- (void) postCheckinToFacebook:(AmigoCheckin *)checkin {
    
	SBJSON *jsonWriter = [[SBJSON new] autorelease];
    
    float longitude = [checkin.lon floatValue];
    float latitude = [checkin.lat floatValue];
    
    NSString *message = @"";
    
	NSMutableDictionary *coordinatesDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                  [NSString stringWithFormat: @"%f", latitude], @"latitude",
                                                  [NSString stringWithFormat: @"%f", longitude], @"longitude",
                                                  nil];
    
	NSString *coordinates = [jsonWriter stringWithObject:coordinatesDictionary];
    
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   checkin.place_id, @"place", //The PlaceID
								   coordinates, @"coordinates", // The latitude and longitude in string format (JSON)
								   message, @"message", // The status message
								   nil];
    
	[self.facebook requestWithGraphPath:@"me/checkins" andParams:params andHttpMethod:@"POST" andDelegate:self.postCheckinDelegate];
}


- (void) postCheckinRequestCompleted{
    NSLog(@"postCheckinRequestCompleted");
}
- (void) postCheckinRequestFailed{
    NSLog(@"postCheckinRequestFailed");
}


- (void) dealloc {
    [queue_ release];
    [user_ release];
    [locdelegate_ release];
    [nearbyDelegate_ release];
    [checkintable_ release];
    [mapViewController_ release];
    [postCheckinDelegate_ release];
    [pet_ release];
    
    [super dealloc];
}

@end
