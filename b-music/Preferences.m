//
//  Preferences.m
//  b-music
//
//  Created by Sergey P on 03.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the
//     purpose of any concept relating to diary/journal keeping.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "Preferences.h"

@interface Preferences ()

@end

@implementation Preferences{
    NSArray * _toolbarSelectedIdentifiers;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    //setting toolbar icons object
    _toolbarSelectedIdentifiers = [NSArray arrayWithObjects:@"GeneralPreferences",@"VkPreferences",@"LastfmPreferences",nil];
    
    /*
     *  Generl Preferences
     *************************/
    //Set checkbox
    if (Settings.sharedInstance.settings.showArtworkDock){
        [self.showDockIconArtworkGeneralBtn setState:1];
    }
    
    //Set checkbox
    if (Settings.sharedInstance.settings.showIconMenubar){
        [self.showMenubarIconGeneralBtn setState:1];
    }
    //Set checkbox
    if (Settings.sharedInstance.settings.searchArtwork) {
        [self.searchArtworkGeneralBtn setState:1];
    }
    
    //Set checkbox
    if (Settings.sharedInstance.settings.showNotafications){
        [self.showNotaficationGeneralBtn setState:1];
    }
    
    /*
     * Lastfm
     ************************/
    
    //Set checkbox
    if (Settings.sharedInstance.settings.scrobbleTrackLastfm){
        [self.scrobbleTracksLastfmBtn setState:1];
    }
    
    //Set checkbox
    if (Settings.sharedInstance.settings.nowPlayingTrackLastfm){
        [self.nowPlayingLastfmBtn setState:1];
    }
    
    //Set username
    [self updateProfileLastfm];
    
    /*
     * VK
     **********/
    //Set username
    [self updateProfileVk];
    
    
    /*
     * Load window
     ****/
    [self loadViewWithTag:1];
}

-(void) loadViewWithTag:(int)tag{
    
    [self.toolbar setSelectedItemIdentifier:[_toolbarSelectedIdentifiers objectAtIndex:tag-1]];
    NSView * view = [self viewWithTag:tag];
    [self.window setContentSize:view.frame.size];
    [self.window.contentView addSubview:view];
}

-(void)showWindow:(id)sender{
    [super showWindow:sender];
    if (_showViewWithTag >0 ) {
        for(NSView * view in [self.window.contentView subviews]){
            [view removeFromSuperview];
        }
        [self loadViewWithTag:_showViewWithTag];
    }
    _showViewWithTag=0;
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar{
    return _toolbarSelectedIdentifiers;
}

-(NSString *) titleWithTag:(NSInteger)tag {
    NSString * title;
    if (tag==1) {
        title = @"General";
    }else if (tag==2) {
        title = @"vk.com";
    }else if (tag==3) {
        title = @"Last.fm";
    }else if (tag==4) {
        title = @"Store";
    }
    return title;
}

-(NSView *) viewWithTag:(NSInteger)tag{
    NSView * view;
    if (tag==1) {
        view=self.generalPreferencesView;
    }else if (tag==2) {
        view=self.vkPreferencesView;
    }else if (tag==3) {
        view=self.lastfmPreferencesView;
    }
    return view;
}

- (IBAction)switchView:(id)sender { NSLog(@"switchView");
    NSView *previousView=[[self.window.contentView subviews] objectAtIndex:0];
    
    NSInteger tag = [sender tag];
    NSView * view=[self viewWithTag:tag];
    [self.window setTitle:[self titleWithTag:tag]];
    
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
 *  Generl Preferences
 *************************/

#pragma mark Genetal Preferences

- (IBAction)showMenubarIconGeneral:(id)sender{ NSLog(@"showMenubarIconGeneral");
    if ([sender state]) {
        Settings.sharedInstance.settings.showIconMenubar=YES;
    }else{
        Settings.sharedInstance.settings.showIconMenubar=NO;
    }
    [Settings.sharedInstance saveSettings];
    
    [self.delegate updateMenuBarIcon];
}


- (IBAction)showDockIconArtworkGeneral:(id)sender{ NSLog(@"showDockIconArtworkGeneral");
    if ([sender state]) {
        Settings.sharedInstance.settings.showArtworkDock=YES;
    }else{
        Settings.sharedInstance.settings.showArtworkDock=NO;
    }
    [Settings.sharedInstance saveSettings];
    
    [self.delegate updateDockIcon];
}


- (IBAction)searchArtworkGeneral:(id)sender{ NSLog(@"searchArtworkGeneral");
    if ([sender state]) {
        Settings.sharedInstance.settings.searchArtwork=YES;
    }else{
        Settings.sharedInstance.settings.searchArtwork=NO;
    }
    [Settings.sharedInstance saveSettings];
}


- (IBAction)showNotaficationGeneral:(id)sender{ NSLog(@"showNotaficationGeneral");
    if ([sender state]) {
        Settings.sharedInstance.settings.showNotafications=YES;
    }else{
        Settings.sharedInstance.settings.showNotafications=NO;
    }
    [Settings.sharedInstance saveSettings];
}

/*
 *  VK Preferences
 *************************/
#pragma mark VK Preferences

- (IBAction)authorizationVk:(id)sender{ NSLog(@"authorizationVk");
    if (!_vkAPI) {
        _vkAPI= [[vkAPI alloc] init];
    }
    
    if (Settings.sharedInstance.settings.token) {
        [self.delegate logoutVkFromPreferences];
        [self updateProfileVk];
    }else{
        [self.vkAPI login];
    }
}

- (IBAction)visitProfileVk:(id)sender{ NSLog(@"VisitVk");
    NSString * strURL;
    if (Settings.sharedInstance.settings.user_id) {
        strURL= [NSString stringWithFormat:@"https://vk.com/id%li",Settings.sharedInstance.settings.user_id];
    }else{
        strURL= @"https://vk.com/";
    }
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:strURL]];
}

-(void) updateProfileVk{
    //Title for button
    if (Settings.sharedInstance.settings.token){
        [self.authorizationVkBtn setTitle:@"Logout"];
    }else{
        [self.authorizationVkBtn setTitle:@"Login"];
    }
    
    if (Settings.sharedInstance.settings.first_name){
        NSString * name =[NSString stringWithFormat:@"%@ %@",Settings.sharedInstance.settings.first_name , Settings.sharedInstance.settings.last_name];
        [self.visitProfileVkBtn setTitle:name];
        [self.avatarBtn setImage:Settings.sharedInstance.settings.avatar];
        [self.avatarBtn setHidden:NO];
        [self.visitProfileVkBtn setImage:nil];
    }else{
        [self.visitProfileVkBtn setImage:[NSImage imageNamed:@"vkTemplate"]];
        [self.visitProfileVkBtn setTitle:@""];
        [self.avatarBtn setHidden:YES];
    }
}

/*
 *  Lastfm Preferences
 *************************/
#pragma mark Lastfm Preferences
- (IBAction)authorizeLastfm:(id)sender{ NSLog(@"AuthorizeLastfm");
    
    if (!_lastfmAPI) {
        _lastfmAPI= [[LastfmAPI alloc] init];
    }
    
    if (Settings.sharedInstance.settings.sessionLastfm) {
        [self.lastfmAPI unAuthorize];
        [self updateProfileLastfm];
    }else{
        [self.lastfmAPI authorize];
    }
}
- (IBAction)nowPlayingLastfm:(id)sender{ NSLog(@"nowPlayngLastfm");
    if ([sender state]) {
        Settings.sharedInstance.settings.nowPlayingTrackLastfm=YES;
    }else{
        Settings.sharedInstance.settings.nowPlayingTrackLastfm=NO;
    }
    [Settings.sharedInstance saveSettings];
}
- (IBAction)scrobbleTracksLastfm:(id)sender{ NSLog(@"scrobbleTracksLastfm");
    if ([sender state]) {
        Settings.sharedInstance.settings.scrobbleTrackLastfm=YES;
    }else{
        Settings.sharedInstance.settings.scrobbleTrackLastfm=NO;
    }
    [Settings.sharedInstance saveSettings];
}

- (IBAction)visitProfileLastfm:(id)sender { NSLog(@"VisitProfileLastfm");
    NSString * strURL;
    if ([[sender title] isEqualToString:@""]){
         strURL=@"http://last.fm/";
    }else{
        strURL= [NSString stringWithFormat:@"http://last.fm/user/%@",[sender title]];
    }
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:strURL]];
}

-(void) updateProfileLastfm{
    //Set checkbox
    if (Settings.sharedInstance.settings.sessionLastfm){
        [self.authorizeLastfmBtn setTitle:@"Unauthorize"];
    }else{
        [self.authorizeLastfmBtn setTitle:@"Authorize"];
    }
    
    if (Settings.sharedInstance.settings.nameLastfm){
        [self.visitProfileLastfmBtn setTitle:Settings.sharedInstance.settings.nameLastfm];
        [self.visitProfileLastfmBtn setImage:nil];
    }else{
        [self.visitProfileLastfmBtn setTitle:@""];
        [self.visitProfileLastfmBtn setImage:[NSImage imageNamed:@"lastfmLogoTemplate"]];
    }
}

/*
 * Store
 *************************/
#pragma mark Store Preferences
- (IBAction)restorePurchase:(id)sender {
    [self loading:YES];
}

- (IBAction)purchaseStore:(id)sender{
    [self loading:YES];
}

-(void) loading:(BOOL)flag{
    if (flag) {
        [self.progressIndicatorStore startAnimation:self];
    }else{
        [self.progressIndicatorStore stopAnimation:self];
    }
    [self.progressIndicatorStore setHidden:!flag];
    [self.purchaseBtnStore setEnabled:!flag];
    [self.restorePurchaseBtn setEnabled:!flag];
}

-(void)stateString:(NSString *)text
             color:(NSColor *)color{
    [self.stateStore setStringValue:text];
    [self.stateStore setTextColor:color];
}

-(void)productInformation:(NSString *)title
              description:(NSString*)description
                    price:(NSString*)price
                isUnlocked:(BOOL)isUnlocked{
    
    
    [self.titleStore        setStringValue:title];
    [self.descriptionStore  setStringValue:description];
    [self loading:NO];
    
    if ([price isEqualTo:@""]){
        [self.purchaseBtnStore setHidden:YES];
        [self.purchaseBtnStore setEnabled:NO];
    }else{
        [self.purchaseBtnStore  setTitle:price];
        [self.purchaseBtnStore setHidden:NO];
        [self.purchaseBtnStore setEnabled:YES];
    }
    
    if (isUnlocked) {
        [self.iconLockStore setImage:[NSImage imageNamed:@"NSLockUnlockedTemplate"]];
    }else{
        [self.iconLockStore setImage:[NSImage imageNamed:@"NSLockLockedTemplate"]];
    }
}

@end
