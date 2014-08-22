//
//  JRDMainWindowController.m
//  DrawingBoard
//
//  Created by Jordan Dobson on 8/19/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDMainWindowController.h"
#import "JRDShapesViewController.h"
#import "JRDRatioViewController.h"
#import "JRDGraphViewController.h"


@interface JRDMainWindowController ()
@property (strong, nonatomic) JRDShapesViewController *shapesViewController;
@property (strong, nonatomic) JRDGraphViewController  *graphViewController;
@property (strong, nonatomic) JRDRatioViewController  *ratioViewController;
@property (strong) IBOutlet NSToolbar *toolbar;


@end

@implementation JRDMainWindowController

- (id)init {
    self = [super initWithWindowNibName:NSStringFromClass(self.class)];
    if (self) { }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [self displayShapesView];
    [self.toolbar setSelectedItemIdentifier: @"shapes"];
}

-(void)displayViewController:(NSViewController *)vc
{
    vc.view.frame = [self.window.contentView bounds];
    vc.view.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
    [self.window.contentView addSubview: vc.view];
}

#pragma mark ToolBar Button Actions

-(IBAction)shapesToolBarHit:(id)sender { [self displayShapesView]; }
-(IBAction)graphsToolBarHit:(id)sender { [self displayGraphsView]; }
-(IBAction)ratioToolBarHit: (id)sender { [self displayRatioView ]; }

#pragma mark Display View Methods

-(void)displayShapesView
{
    if(!self.shapesViewController){
        self.shapesViewController = [JRDShapesViewController new];
    }
    [self displayViewController: self.shapesViewController];
}

-(void)displayGraphsView{
    if(!self.graphViewController){
        self.graphViewController = [JRDGraphViewController new];
    }
    [self displayViewController: self.graphViewController];
}

-(void)displayRatioView{
    if(!self.ratioViewController){
        self.ratioViewController = [JRDRatioViewController new];
    }
    [self displayViewController: self.ratioViewController];
}



@end
