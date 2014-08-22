//
//  JRDAppDelegate.m
//  DrawingBoard
//
//  Created by Jordan Dobson on 8/19/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDAppDelegate.h"
#import "JRDMainWindowController.h"

@interface JRDAppDelegate ()
    @property (strong, nonatomic) JRDMainWindowController *mainWindowController;
@end

@implementation JRDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.mainWindowController = [JRDMainWindowController new];
    [self.mainWindowController showWindow:self];
}
@end
