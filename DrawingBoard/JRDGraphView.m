//
//  JRDGraphView.m
//  DrawingBoard
//
//  Created by Jordan Dobson on 8/21/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDGraphView.h"

@interface JRDGraphView ()
    @property float rectWidth;
    @property float rectHeight;
    @property NSRect theDirtyRect;
    @property (copy, nonatomic) NSArray *points;
@end

@implementation JRDGraphView

-(void)drawGraph:(NSArray*)points
{
    self.points = points;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    self.theDirtyRect = dirtyRect;

    [super drawRect:dirtyRect];
    [self drawBackground: dirtyRect];

    self.rectWidth  = dirtyRect.size.width;
    self.rectHeight = dirtyRect.size.height;

    double divider = self.points.count;
    float  step    = self.rectWidth/divider;
    int    idx     = 1;

    NSBezierPath *graph  = [NSBezierPath bezierPath];
    [graph moveToPoint: NSMakePoint(0, 0)];

    for (NSNumber *point in self.points) {
        [graph lineToPoint:NSMakePoint(step*idx, (point.floatValue * self.rectHeight))];
        idx++;
    }

    [graph lineToPoint:NSMakePoint(step*divider, 0)];
    [graph lineToPoint:NSMakePoint(0, 0)];
    [graph closePath];
    [[NSColor colorWithPatternImage: [NSImage imageNamed: @"transparent-green"]] set];
    [graph fill];

    [[NSColor colorWithPatternImage: [NSImage imageNamed: @"greenOutline"]] set];
    graph.lineJoinStyle = NSRoundLineJoinStyle;
    graph.lineWidth = 3;
    [graph stroke];

    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRect:dirtyRect];
    [[NSColor whiteColor] set];
    bgPath.lineWidth = 3;
    [bgPath stroke];
}

- (void)drawBackground:(NSRect)dirtyRect
{
    NSImage *halftone = [NSImage imageNamed: @"lined"];
    [[NSColor colorWithPatternImage: halftone] set];
    [NSBezierPath fillRect: dirtyRect];
}

@end
