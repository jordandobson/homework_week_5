//
//  JRDGraphViewController.m
//  DrawingBoard
//
//  Created by Jordan Dobson on 8/21/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDGraphViewController.h"
#import "JRDGraphView.h"
#import "JRDRandomPercentGenerator.h"

@interface JRDGraphViewController ()
    @property (strong, nonatomic) IBOutlet JRDGraphView *graphView;
    @property NSArray *points;
@end

@implementation JRDGraphViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass(self.class) bundle:nil];
    if (self) {
    }
    return self;

}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self refreshGraph:nil];
}

- (IBAction)refreshGraph:(id)sender {
    NSArray *points = [JRDRandomPercentGenerator arrayOfPercents: 10];
    [self.graphView drawGraph: points];
}

@end
