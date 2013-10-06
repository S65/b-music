//
//  SheetWindowController.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@protocol SheetDelegate <NSObject>
-(void) cancelSheet:(NSString*)token user_id:(NSInteger)user_id execute:(SEL)someFunc;
@end

@interface SheetWindowController : NSWindowController

@property (weak) id <SheetDelegate> delegate;
@property (weak) IBOutlet WebView *webview;
-(IBAction)cancel:(id)sender;

-(void)clearCookie;
-(void) loadURL:(NSString *) URLsring execute:(SEL)someFunc;
@end
