//
//  JRDShapesView.m
//  DrawingBoard
//
//  Created by Jordan Dobson on 8/21/14.
//  Copyright (c) 2014 Jordan Dobson. All rights reserved.
//

#import "JRDShapesView.h"

@interface JRDShapesView ()
    @property NSPoint *theCenterPoint;
    @property float rectMin;
    @property (strong, nonatomic) NSImage *imageStroke;
    @property (strong, nonatomic) NSImage *imageBg;
@end

@implementation JRDShapesView

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

    NSPoint cPoint      = NSMakePoint((dirtyRect.size.width/2), (dirtyRect.size.height/2));
    self.theCenterPoint = &(cPoint);
    self.imageStroke    = [NSImage imageNamed: @"darkred"];
    self.imageBg        = [NSImage imageNamed: @"red50"];

    if(dirtyRect.size.width > dirtyRect.size.height){
        self.rectMin = dirtyRect.size.height;
    }else{
        self.rectMin = dirtyRect.size.width;
    }

    [self drawBackground: dirtyRect];
    [self drawSquare:     dirtyRect];
    [self drawCircle:     dirtyRect];
    [self drawTriangle:   dirtyRect];
}

- (void)drawBackground:(NSRect)dirtyRect
{
    NSImage *halftone = [NSImage imageNamed: @"grid"];
    [[NSColor colorWithPatternImage: halftone] set];
    [NSBezierPath fillRect: dirtyRect];

    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRect:dirtyRect];
    [[NSColor whiteColor] set];
    bgPath.lineWidth = 3;
    [bgPath stroke];
}

- (void)drawCircle:(NSRect)dirtyRect
{
    NSBezierPath * circlePath = [NSBezierPath bezierPath];
    [circlePath appendBezierPathWithArcWithCenter:*(self.theCenterPoint) radius:(self.rectMin/3) startAngle:0 endAngle:360];
    [[NSColor colorWithPatternImage: self.imageBg] set];
    [circlePath fill];
    [[NSColor colorWithPatternImage: self.imageStroke] set];
    circlePath.lineJoinStyle = NSRoundLineJoinStyle;
    circlePath.lineWidth = 2;
    [circlePath stroke];
}

- (void)drawSquare:(NSRect)dirtyRect
{
    NSBezierPath * squarePath = [NSBezierPath bezierPath];
    [[NSColor colorWithPatternImage: self.imageBg] set];
    [squarePath moveToPoint: *(self.theCenterPoint)];
    float size = self.rectMin/1.48;
    [squarePath relativeMoveToPoint: NSMakePoint(-(size/2), -(size/2))];
    [squarePath relativeLineToPoint:NSMakePoint(0,(size))];
    [squarePath relativeLineToPoint:NSMakePoint((size),0)];
    [squarePath relativeLineToPoint:NSMakePoint(0,-(size))];
    [squarePath relativeLineToPoint:NSMakePoint(-(size),0)];
    [squarePath closePath];
    [squarePath fill];
    [[NSColor colorWithPatternImage: self.imageStroke] set];
    squarePath.lineJoinStyle = NSRoundLineJoinStyle;
    squarePath.lineWidth = 2;
    [squarePath stroke];
}

- (void)drawTriangle:(NSRect)dirtyRect
{
    NSBezierPath * trianglePath = [NSBezierPath bezierPath];
    [[NSColor colorWithPatternImage: self.imageBg] set];
    [trianglePath moveToPoint: *(self.theCenterPoint)];
    float size = self.rectMin/2;
    [trianglePath relativeMoveToPoint: NSMakePoint(0, size/1.5)];
    [trianglePath relativeLineToPoint: NSMakePoint((size/1.75), -(size))];
    [trianglePath relativeLineToPoint: NSMakePoint(-(size*1.15), 0)];
    [trianglePath relativeLineToPoint: NSMakePoint((size/1.75), (size))];
    [trianglePath closePath];
    [trianglePath fill];
    [[NSColor colorWithPatternImage: self.imageStroke] set];
    trianglePath.lineJoinStyle = NSRoundLineJoinStyle;
    trianglePath.lineWidth = 2;
    [trianglePath stroke];
}

@end
