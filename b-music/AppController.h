//
//  AppController.h
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SheetWindowController.h"
#import "RuntimeSlider.h"
#import "Volume.h"

#import "RepeatButton.h"
#import "ShuffleButton.h"
#import "ShowSearchButton.h"

//
#import "TableCellView.h"

#import "PlayButton.h"
#import "PlayButtonCell.h"
#import "PlayerController.h"

#import "AddButtonCell.h"
#import "RemoveButtonCell.h"

#import "ControlsView.h"
#import "Settings.h"

#import "Api.h"
#import "LastfmAPI.h"

@interface AppController : NSObject<NSWindowDelegate,NSTableViewDataSource,NSTableViewDelegate,SheetDelegate,PlayerDelegate,ControlsViewDelegate>{
    NSStatusItem *statusItem;
}

@property SheetWindowController * sheet;
@property Settings * S;
@property PlayerController * PC;
@property Api * api;
@property LastfmAPI * lastfmAPI;

@property (weak) IBOutlet NSTableView * tableview;
@property (weak) IBOutlet ControlsView *Controls0;
@property (weak) IBOutlet NSView *Controls1;
@property (weak) IBOutlet NSView *Controls2;

@property (weak) IBOutlet NSLayoutConstraint *searchViewHeight;
@property (weak) IBOutlet NSSearchField *searchField;

@property (weak) IBOutlet NSView *BottomControls0;
@property (weak) IBOutlet NSView *BottomControls1;

@property (weak) IBOutlet NSMenu *controlsMenu;
@property (weak) IBOutlet NSMenu *editMenu;
@property (weak) IBOutlet NSMenu *viewMenu;
@property (weak) IBOutlet NSMenu *windowMenu;
@property (weak) IBOutlet NSMenu *dockMenu;
@property (weak) IBOutlet NSMenu *statusMenu;


-(IBAction)play:(id)sender;
-(IBAction)next:(id)sender;
-(IBAction)previous:(id)sender;
-(IBAction)decreaseVolume:(id)sender;
-(IBAction)increaseVolume:(id)sender;
-(IBAction)mute:(id)sender;

-(IBAction)shuffle:(id)sender;
-(IBAction)repeat:(id)sender;
-(IBAction)alwaysOnTop:(id)sender;
-(IBAction)visitWebsite:(id)sender;

-(IBAction)more:(id)sender;
-(IBAction)addTrack:(id)sender;
-(IBAction)removeTrack:(id)sender;

-(IBAction)volume:(id)sender;
-(IBAction)runtime:(id)sender;
-(IBAction)switchRuntime:(id)sender;
-(IBAction)showSearch:(id)sender;
-(IBAction)search:(id)sender;
-(IBAction)showPlaylist:(id)sender;
-(IBAction)gotoCurrentTrack:(id)sender;
-(IBAction)close:(id)sender;
-(IBAction)logout:(id)sender;

@end
