//
//  LastfmAPI.h
//  b-music
//
//  Created by Sergey P on 24.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LastfmAPIDelegate <NSObject>

-(void) finishAuthorizeWithSession:(NSString *)session
                          username:(NSString*)username;

@end


@interface LastfmAPI : NSObject

@property (weak) id <LastfmAPIDelegate> delegate;

-(NSImage * )getImageWithArtist:(NSString *)artist
                          track:(NSString *)track
                           size:(NSInteger )size;
-(void) authorize;

-(void)parseTokenUsernameFormString:(NSString *)tokenStr;

#pragma mark Last.fm Methods

-(id)auth_getSession:(NSString *)token;

-(id)track_getInfo:(NSString *)artist
             track:(NSString *)track;

-(void) track_updateNowPlaying:(NSString *)session
                      artist:(NSString *)artist
                       track:(NSString *)track
                    duration:(NSString *)duration;

-(id) track_scrobble:(NSString *)session
              artist:(NSString *)artist
               track:(NSString *)track;

@end
