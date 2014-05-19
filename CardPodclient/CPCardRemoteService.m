//
//  CPCardRemoteService.m
//  CardPodclient
//
//  Created by Patrick Dinger on 02.04.14.
//  Copyright (c) 2014 Patrick Dinger. All rights reserved.
//

#import <PXLib/PXLib.h>
#import <AddressBook/AddressBook.h>
#import "CPCardRemoteService.h"
#import "CPPodIdentifier.h"
#import "CPAddressBookService.h"

@implementation CPCardRemoteService

static CPCardRemoteService *sharedService = nil;

+ (CPCardRemoteService *)sharedService {
    if (nil != sharedService) {
        return sharedService;
    }

    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        sharedService = [[CPCardRemoteService alloc] init];
    });

    return sharedService;
}

- (void)fetchRemoteCardsForAllUsers {
    NSError *error;
    NSArray *persons = [CPPerson fetchAll:&error];

    if (persons) {
        for (CPPerson *person in persons) {
            NSString *identifier = person.identifier;
            if (identifier) {
                CPPodIdentifier *podIdentifier = [[CPPodIdentifier alloc] initWithString:identifier];
                NSString *host = [podIdentifier host];
                NSString *user = [podIdentifier user];
                NSString *token = [podIdentifier token];

                // token can be nil
                if (host && user) {
                    ABPerson *remoteCard = [self fetchRemoteCardForUser:user atHost:host usingToken:token];
                    if (remoteCard) {
                        person.remoteCard = remoteCard.vCardRepresentation;
                    }
                }

            }
        }
    }
}

// Private
- (ABPerson *)fetchRemoteCardForUser:(NSString *)user atHost:(NSString *)host usingToken:(NSString *)token {

    NSString *urlString = [NSString stringWithFormat:@"http://%@/card/%@", host, user];
    NSLog(@"fetching from %@", urlString);

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    if (!data) {
        NSLog(@"Got no data - %@", error);
    }

    ABPerson *person;
    if (data) {
        person = [[ABPerson alloc] initWithVCardRepresentation:data];
    }

    return person;
}

// ABAdressBook addRecord


- (void)uploadMyCard {
    ABPerson *me = [[ABAddressBook sharedAddressBook] me];
    NSString *identifier = [CPAddressBookService podIdentifierFromPerson:me];

    // look in linked people
    if (!identifier) {
        for (ABRecord *record in me.linkedPeople) {
            identifier = [CPAddressBookService podIdentifierFromPerson:record];
            if (identifier) {
                break;
            }
        }
    }

    if (!identifier) {
        NSLog(@"Warning: ME card has no cardpod identifier!");
        return;
    }

    CPPodIdentifier *podIdentifier = [[CPPodIdentifier alloc] initWithString:identifier];

    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"CPAPIKey"];
    NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:@"CPMail"];

    if (!token || !email) {
        NSLog(@"Missing Credentials - request aborted.");
        return;
    }

    NSString *urlString = [NSString stringWithFormat:@"http://%@/manage/pubcard", podIdentifier.host];
    NSURL *url = [NSURL URLWithString:urlString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                                       timeoutInterval:30.0];
    [request setValue:email forHTTPHeaderField:@"X-User-Email"];
    [request setValue:token forHTTPHeaderField:@"X-User-Token"];

    // http://stackoverflow.com/questions/125306/how-can-i-upload-a-photo-to-a-server-with-the-iphone


    static NSString * const BOUNDRY = @"---------------------podboundary1212";

    NSData *data = [me vCardRepresentation];
    [request setHTTPMethod:@"PUT"];
    [request setValue:
            [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDRY]
      forHTTPHeaderField:@"Content-Type"];

    NSMutableData *postData = [NSMutableData dataWithCapacity:[data length] + 512];
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:
            [[NSString stringWithFormat:
                    @"Content-Disposition: form-data; name=\"%@\"; filename=\"card.vcf\"\r\n\r\n", @"user[pubcard]"]
                    dataUsingEncoding:NSUTF8StringEncoding]];

    // Add content-type
   // [postData appendData:[[NSString stringWithString:@"Content-Type:text/directory\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];

    [postData appendData:data];
    [postData appendData:
            [[NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDRY] dataUsingEncoding:NSUTF8StringEncoding]];

    [request setHTTPBody:postData];
    NSString *debug = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(debug);

    // text/directory



    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Response was %@", content);
    }];
}
@end