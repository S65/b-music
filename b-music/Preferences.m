//
//  Preferences.m
//  b-music
//
//  Created by Sergey P on 03.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "Preferences.h"

@interface Preferences ()

@end

@implementation Preferences

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithWindowNibName:@"Preferences"];
    if (self) {
        _se = [[Settings alloc] init];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self.toolbar setSelectedItemIdentifier:@"GeneralPreferences"];
    [self.window setContentSize:self.generalPreferencesView.frame.size];
    [self.window.contentView addSubview:self.generalPreferencesView];
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar{
    return [NSArray arrayWithObjects:@"GeneralPreferences",@"VkPreferences",@"LastfmPreferences",nil];
}

- (IBAction)switchView:(id)sender { NSLog(@"switchView");
    NSInteger tag= [sender tag];
    NSView * view;
    NSView *previousView=[[self.window.contentView subviews] objectAtIndex:0];
    
    if (tag==1) {
        view=self.generalPreferencesView;
        [self.window setTitle:@"General"];
    }else if (tag==2) {
        view=self.vkPreferencesView;
        [self.window setTitle:@"vk.com"];
    }else if (tag==3) {
        view=self.lastfmPreferencesView;
        [self.window setTitle:@"Last.fm"];
    }
    
    [NSAnimationContext beginGrouping];
    if ([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask){
        [[NSAnimationContext currentContext] setDuration:1.0];
    }
    
    NSRect newFrame = [self newFrameForNewContentView:view];
    [[self.window animator] setFrame:newFrame display:YES];
    [[self.window.contentView animator] replaceSubview:previousView with:view];
    [NSAnimationContext endGrouping];
}

- (NSRect)newFrameForNewContentView:(NSView*)view {
    NSWindow *window = [self window];
    NSRect newFrameRect = [window frameRectForContentRect:[view frame]];
    NSRect oldFrameRect = [window frame];
    NSSize newSize = newFrameRect.size;
    NSSize oldSize = oldFrameRect.size;
    
    NSRect frame = [window frame];
    frame.size = newSize;
    frame.origin.y -= (newSize.height - oldSize.height);
    return frame;
}
/*
 *  VK Preferences
 *************************/
#pragma mark VK Preferences

- (IBAction)authorizationVk:(id)sender{ NSLog(@"authorizationVk");
    
}

- (IBAction)offlineVk:(id)sender{ NSLog(@"AuthorizeLastfm");
    
}

/*
 *  Lastfm Preferences
 *************************/
#pragma mark Lastfm Preferences
- (IBAction)authorizeLastfm:(id)sender{ NSLog(@"AuthorizeLastfm");
    if (!_lastfmAPI) {
        _lastfmAPI= [[LastfmAPI alloc] init];
    }
    [self.lastfmAPI authorize];
}
- (IBAction)nowPlayingLastfm:(id)sender{ NSLog(@"nowPlayngLastfm");
    
}
- (IBAction)scrobbleTracksLastfm:(id)sender{ NSLog(@"scrobbleTracksLastfm");
    
}

@end
